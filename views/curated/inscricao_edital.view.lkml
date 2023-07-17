view: inscricao_edital {
  derived_table: {
    datagroup_trigger: pbh_data
    publish_as_db_view: yes

    sql:
      with nota as (
        select i.nu_inscricao, i.nu_projeto, nota, i.no_empreendedor, i.setor_analise as setor,null as no_categoria from trial-pbh.raw.tmp_lmic_aprovado a join trial-pbh.raw.tmp_lmic_inscrito i on a.nu_projeto=i.nu_projeto
        union all
        select i.nu_inscricao, i.nu_projeto, nota, i.no_empreendedor, "AUDIOVISUAL",i.no_categoria from trial-pbh.raw.tmp_bhtelas_aprovado a join trial-pbh.raw.tmp_bhtelas_inscrito i on a.nu_projeto=i.nu_projeto
      )
        SELECT
          FARM_FINGERPRINT(e.inscricao) as pk
          ,FARM_FINGERPRINT(upper(regexp_replace(REGEXP_REPLACE(NORMALIZE(no_empreendedor, NFD), r"\pM", ''),r'[^\w\- ]|  +',''))) as fk_empeendedor
          ,FARM_FINGERPRINT(nu_projeto) as fk_projeto
          ,EDITAL  AS edital
          ,e.inscricao
          ,cast(split(nu_projeto,'/')[0] as int64) as nu_projeto
          ,cast(split(nu_projeto,'/')[1] as int64) as ano_projeto
          ,SAFE_CAST(REPLACE(nota,",",".") AS FLOAT64) AS nota
          ,case
            when CONTAINS_SUBSTR(n.setor,'(') then trim(split(n.setor,'(')[0])
            else n.setor
          end as setor_analise
          ,case
            when CONTAINS_SUBSTR(n.setor,'(') then trim(split(n.setor,'(')[0])
            when n.setor="AUDIOVISUAL" and no_categoria="1" then "PRODUÇÃO"
            when n.setor="AUDIOVISUAL" and no_categoria="2" then "FESTIVAIS"
            when n.setor="AUDIOVISUAL" and no_categoria="3" then "JOGOS ELETRÔNICOS"
            when n.setor="AUDIOVISUAL" and no_categoria="4" then "AUDIOVISUAL COMUNITÁRIO"
            when n.setor="AUDIOVISUAL" and no_categoria="5" then "PESQUISA E FORMATO LIVRE"
            else null
          end as subsetor_analise
          ,SAFE_CAST(REPLACE(VALOR_SOLICITADO,",",".") AS FLOAT64) AS valor_solicitado
          ,SAFE_CAST(REPLACE(VALOR_APROVADO,",",".") AS FLOAT64) AS valor_aprovado
        FROM trial-pbh.raw.tmp_edtital_aprovado e
        left join nota n on e.inscricao=n.nu_inscricao
    ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
  }

  dimension: fk_empeendedor {
    hidden: yes
  }
  dimension: fk_projeto {
    hidden: yes
  }

  dimension: edital {
    hidden: yes
    type: string
  }
  dimension: edital_short {
    label: "Edital"
    description: "Mecanismo no qual o projeto foi inscrito. No ano de 2020 houve o BH nas telas e LMIC."
    sql:
      case
        when ${edital}="EDITAL BH NAS TELAS 2020 - FUNDO" then "BH Nas Telas"
        when ${edital}="EDITAL LMIC 2020 – FUNDO MUNICIPAL DE CULTURA" then "LMIC"
      end
    ;;
    link: {
      label: "Publicações"
      url: "https://prefeitura.pbh.gov.br/cultura/editais{% if value=='BH Nas Telas' %}/lmic-2020-bhnastelas{% elsif value=='LMIC' %}/lmic-2020-fundo{% else %}/{% endif %} "
    }

  }
  dimension: inscricao {
    label: "Codigo Inscricao"
    type: string
  }
  dimension: nu_projeto {
    label: "Numero"
    description: "Numero do projeto"
    type: number
    value_format: "0"
  }
  dimension: ano_projeto {
    label: "Ano"
    description: "Ano do projeto"
    type: number
    value_format: "0"
  }
  dimension: nota {
    label: "Nota Final"
    description: "Nota final do projeto no Edital"
    type: number
    value_format: "0.0"
  }

  dimension: valor_solicitado {
    hidden: yes
  }
  measure: sum_valor_solicitado{
    label: "Valor Solicitado"
    description: "Valor solicitado por projeto no Edital"
    type: sum
    sql: ${valor_solicitado} ;;
    value_format: "\R$#,##0.00"
  }

  measure: avg_valor_solicitado {
    label: "Média Valor Solicitado"
    description: "Média do valor solicitado por projeto no Edital"
    type: sum
    sql: ${valor_solicitado} ;;
    value_format: "\R$#,##0.00"
  }

  dimension: valor_aprovado  {
    hidden: yes
  }

  measure: sum_valor_aprovado{
    label: "Valor Aprovado"
    description: "Valor aprovado por projeto no Edital"
    type: sum
    sql: ${valor_aprovado} ;;
    value_format: "\R$#,##0.00"
  }

  measure: avg_valor_aprovado {
    label: "Média Valor Solicitado"
    description: "Média do valor solicitado por projeto no Edital"
    type: sum
    sql: ${valor_aprovado} ;;
    value_format: "\R$#,##0.00"
  }

}
