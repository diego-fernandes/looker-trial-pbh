view: projeto {

  derived_table: {
    datagroup_trigger: pbh_data
    publish_as_db_view: yes

    sql:
      with projeto as (
        select inscricao, nu_projeto, nome_projeto, setor, setor_analise from trial-pbh.raw.tmp_lmic_inscricao
        union all
        select inscricao, nu_projeto, no_projeto, "AUDIOVISUAL", null from trial-pbh.raw.tmp_bhtelas_inscricao
      )
        SELECT
          FARM_FINGERPRINT(nome_projeto) as pk
          ,trim(nome_projeto,'"') as nome_projeto
          ,ESTIMATIVA_PUBLICO as estimativa_publico
          ,REGEXP_EXTRACT_ALL(PERFIL_PUBLICO,r'\w[^,]*\w')  AS perfil_publico
          ,ARRAY_LENGTH(REGEXP_EXTRACT_ALL(PERFIL_PUBLICO,r'\w[^,]*\w')) qtd_perfis
          ,PROFISSIONAIS  AS profissionais
          ,if(PROJETO_NOVO="SIM",true,false)  AS projeto_novo
          ,case
            when CONTAINS_SUBSTR(e.SETOR,'(') then trim(split(e.SETOR,'(')[0])
            else e.SETOR
          end as setor
          ,case
            when CONTAINS_SUBSTR(e.SETOR,'(') then trim(split(e.SETOR,'(')[1],')')
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

  dimension: nu_projeto {
    label: "Numero"
    type: number
  }
  dimension: ano_projeto {
    label: "Ano"
    type: number
  }
  dimension: nome_projeto {
    label: "Nome"
    type: string
  }
  dimension: estimativa_publico {
    label: "Estimativa de Publico"
    description: "Estimativa da quantidade de pessoas do público alvo que o projeto buscou atender."
    type: number
  }
  dimension: profissionais {
    label: "Profissionais Contratados"
    description: "Número de contratações que são geradas com a execução do projeto."
    type: number
  }
  dimension: projeto_novo {
    label: "É projeto novo?"
    description: "Indica se o projeto é inédito ou sua primeira edição."
    type: yesno
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
    type: sum
  }

}
