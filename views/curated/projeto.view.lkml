view: projeto {

  derived_table: {
    datagroup_trigger: pbh_data
    publish_as_db_view: yes

    sql:
      with inscricao as (
        select trim(nu_inscricao) as nu_inscricao, trim(nu_projeto) as nu_projeto, no_projeto, setor, setor_analise, null as no_categoria from trial-pbh.raw.tmp_lmic_inscrito
        union all
        select trim(nu_inscricao), trim(nu_projeto), no_projeto, "AUDIOVISUAL", null , no_categoria from trial-pbh.raw.tmp_bhtelas_inscrito
      )
        SELECT
          FARM_FINGERPRINT(nu_projeto) as pk
          ,regexp_replace(no_projeto,r'[^\p{Latin}]|\n|  +','') as nome_projeto
          ,case
            when CONTAINS_SUBSTR(i.setor,'(') then trim(split(i.setor,'(')[0])
            else i.setor
          end as setor
          ,case
            when CONTAINS_SUBSTR(i.setor,'(') then trim(split(i.setor,'(')[1],')')
            when i.setor="AUDIOVISUAL" and no_categoria="1" then "PRODUÇÃO"
            when i.setor="AUDIOVISUAL" and no_categoria="2" then "FESTIVAIS"
            when i.setor="AUDIOVISUAL" and no_categoria="3" then "JOGOS ELETRÔNICOS"
            when i.setor="AUDIOVISUAL" and no_categoria="4" then "AUDIOVISUAL COMUNITÁRIO"
            when i.setor="AUDIOVISUAL" and no_categoria="5" then "PESQUISA E FORMATO LIVRE"
            else null
          end as subsetor
          ,ESTIMATIVA_PUBLICO as estimativa_publico
          ,REGEXP_EXTRACT_ALL(PERFIL_PUBLICO,r'\w[^,]*\w')  AS perfil_publico
          ,ARRAY_LENGTH(REGEXP_EXTRACT_ALL(PERFIL_PUBLICO,r'\w[^,]*\w')) qtd_perfis
          ,PROFISSIONAIS  AS profissionais
          ,PROJETO_NOVO AS projeto_novo
          ,SAFE_CAST(REPLACE(VALOR_PROJETO,",",".") AS FLOAT64) AS valor_projeto
        FROM inscricao i
        left join trial-pbh.raw.tmp_edtital_aprovado e
          on trim(e.INSCRICAO)=i.nu_inscricao
    ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
  }
  drill_fields: [pk]

  dimension: nome_projeto {
    label: "Nome"
    type: string
  }
  dimension: estimativa_publico {
    hidden: yes
    type: number
  }
  measure: sum_estimativa_publico {
    type: sum_distinct
    label: "Estimativa de Publico"
    description: "Estimativa da quantidade de pessoas do público alvo que o projeto buscou atender."
    sql: ${estimativa_publico} ;;
    value_format: "#,##0"
  }

  dimension: profissionais {
    hidden: yes
    type: number
  }
  measure: sum_profissionais {
    label: "Profissionais Contratados"
    description: "Número de contratações que são geradas com a execução do projeto."
    type: sum_distinct
    sql: ${profissionais} ;;
    value_format: "#,##0"
  }

  dimension: projeto_novo {
    hidden: yes
  }
  dimension: projeto_novo_yn {
    label: "é Projeto Novo?"
    description: "Indica se o projeto é inédito ou sua primeira edição."
    type: yesno
    sql: if(${projeto_novo}="NOVO",true,false) ;;
  }

  dimension: setor {
    label: "Setor"
    description: "Área de atuação no qual o projeto se inscreveu. Tais como: artes visuais, dança, circo, patrimônio e literatura."
    type: string
  }
  dimension: subsetor {
    label: "Subsetor"
    description: "Área de atuação no qual o projeto se inscreveu. Tais como: artes visuais, dança, circo, patrimônio e literatura."
    type: string
  }

  dimension: perfil_publico {
    hidden: yes
    description: "Público alvo que pretende atender através do projeto (qualitativo)."
  }
  dimension: qtd_perfis {
    hidden: yes
    description: "Público alvo que pretende atender através do projeto (qualitativo)."
  }

  measure: valor_projeto {
    label: "Valor"
    description:  "Soma do valor total do projeto (captação não exclusiva do edital)."
    type: sum_distinct
    value_format: "\R$#,##0.00"
  }

  measure: count {
    label: "Quantidade"
    type: count
  }


}
