view: inscricao_edital {
  derived_table: {
    datagroup_trigger: pbh_data
    publish_as_db_view: yes

    sql:
      with nota as (
        select inscricao, no_projeto, nota from trial-pbh.raw.tmp_lmic_aprovados a join trial-pbh.raw.tmp_lmic_inscricao i on a.no_projeto=i.nu_projeto
        union all
        select inscricao, a.no_projeto, nota from trial-pbh.raw.tmp_bhnastelas_aprovados a join trial-pbh.raw.tmp_bhtelas_inscricao i on a.no_projeto=i.nu_projeto
      )
        SELECT
          FARM_FINGERPRINT(inscricao) as pk
          ,FARM_FINGERPRINT(empreendedor) as fk_empeendedor
          ,FARM_FINGERPRINT(no_projeto) as fk_projeto
          ,EDITAL  AS edital
          ,e.inscricao
          ,nota
          ,case
            when CONTAINS_SUBSTR(p.setor,'(') then trim(split(p.setor,'(')[0])
            else p.setor
          end as setor_inscricao
          ,case
            when CONTAINS_SUBSTR(p.setor,'(') then trim(split(p.setor,'(')[0])
            else null
          end as subsetor_inscricao
          ,SAFE_CAST(REPLACE(VALOR_SOLICITADO,",",".") AS FLOAT64) AS VALOR_SOLICITADO
          ,SAFE_CAST(REPLACE(VALOR_APROVADO,",",".") AS FLOAT64) AS VALOR_APROVADO
        FROM trial-pbh.raw.tmp_edtital_aprovado e
        join nota n on e.inscricao=n.inscricao
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
    action: {
      label: "Publicações"
      url: "https://prefeitura.pbh.gov.br/cultura/editais
      {% if value=='BH Nas Telas' %}
       /lmic-2020-bhnastelas
      {% elsif value=='LMIC' %}
        /lmic-2020-fundo
      {% else %}
         /
      {% endif %} "
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
  }
  dimension: ano_projeto {
    label: "Ano"
    description: "Ano do projeto"
    type: number
  }
  dimension: nota {
    label: "Nota Final"
    description: "Nota final do projeto no Edital"
    type: number
  }

  dimension: valor_solicitado {
    hidden: yes
  }
  measure: sum_valor_solicitado{
    label: "Valor Solicitado"
    description: "Valor solicitado por projeto no Edital"
    type: sum
    sql: ${valor_solicitado} ;;
  }

  measure: avg_valor_solicitado {
    label: "Média Valor Solicitado"
    description: "Média do valor solicitado por projeto no Edital"
    type: average
    sql: ${valor_solicitado} ;;
  }

  dimension: valor_aprovado  {
    hidden: yes
  }

  measure: sum_valor_aprovado{
    label: "Valor Aprovado"
    description: "Valor aprovado por projeto no Edital"
    type: sum
    sql: ${valor_aprovado} ;;
  }

  measure: avg_valor_aprovado {
    label: "Média Valor Solicitado"
    description: "Média do valor solicitado por projeto no Edital"
    type: average
    sql: ${valor_aprovado} ;;
  }

}
