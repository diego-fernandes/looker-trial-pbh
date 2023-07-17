view: projeto {

  derived_table: {
    datagroup_trigger: pbh_data
    publish_as_db_view: yes

    sql:
      with projeto as (
        select nu_inscricao, nu_projeto, no_projeto, setor, setor_analise, null as no_categoria from trial-pbh.raw.tmp_lmic_inscrito
        union all
        select nu_inscricao, nu_projeto, no_projeto, "AUDIOVISUAL", null , no_categoria from trial-pbh.raw.tmp_bhtelas_inscrito
      )
        SELECT
          FARM_FINGERPRINT(nu_projeto) as pk
          ,regexp_replace(no_projeto,r'[^\p{Latin}]|\n|  +','') as nome_projeto
          ,ESTIMATIVA_PUBLICO as estimativa_publico
          ,REGEXP_EXTRACT_ALL(PERFIL_PUBLICO,r'\w[^,]*\w')  AS perfil_publico
          ,ARRAY_LENGTH(REGEXP_EXTRACT_ALL(PERFIL_PUBLICO,r'\w[^,]*\w')) qtd_perfis
          ,PROFISSIONAIS  AS profissionais
          ,PROJETO_NOVO AS projeto_novo
          ,case
            when CONTAINS_SUBSTR(e.SETOR,'(') then trim(split(e.SETOR,'(')[0])
            else e.SETOR
          end as setor
          ,case
            when CONTAINS_SUBSTR(e.SETOR,'(') then trim(split(e.SETOR,'(')[1],')')
            when e.setor="AUDIOVISUAL" and no_categoria="1" then "PRODUÇÃO"
            when e.setor="AUDIOVISUAL" and no_categoria="2" then "FESTIVAIS"
            when e.setor="AUDIOVISUAL" and no_categoria="3" then "JOGOS ELETRÔNICOS"
            when e.setor="AUDIOVISUAL" and no_categoria="4" then "AUDIOVISUAL COMUNITÁRIO"
            when e.setor="AUDIOVISUAL" and no_categoria="5" then "PESQUISA E FORMATO LIVRE"
            else null
          end as subsetor
          ,SAFE_CAST(REPLACE(VALOR_PROJETO,",",".") AS FLOAT64) AS valor_projeto
        FROM trial-pbh.raw.tmp_edtital_aprovado e
        join projeto p on e.INSCRICAO=p.inscricao
    ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
  }

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
    value_format: "0"
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
    value_format: "0"
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

}
