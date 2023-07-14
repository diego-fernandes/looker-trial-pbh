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
          cast(split(nu_projeto,'/')[0] as int64) as nu_projeto
          ,cast(split(nu_projeto,'/')[1] as int64) as ano_projeto
          ,nome_projeto
          ,ESTIMATIVA_PUBLICO
          ,CAST(split(PERFIL_PUBLICO,",") AS ARRAY<STRING>)  AS perfil_publico
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
          ,SAFE_CAST(REPLACE(VALOR_PROJETO,",",".") AS FLOAT64) AS VALOR_PROJETO
        FROM trial-pbh.raw.tmp_edtital_aprovado e
        join projeto p on e.INSCRICAO=p.inscricao
    ;;
  }

  dimension: nu_projeto {}
  dimension: ano_projeto {}
  dimension: nome_projeto {}
  dimension: estimativa_publico {
    description: "Estimativa da quantidade de pessoas do público alvo que o projeto buscou atender."
    type: number
  }
  dimension: profissionais {
    description: "Número de contratações que são geradas com a execução do projeto."
    type: number
  }
  dimension: projeto_novo {
    description: "Indica se o projeto é inédito ou sua primeira edição."
  }
  dimension: setor {
    description: "Área de atuação no qual o projeto se inscreveu. Tais como: artes visuais, dança, circo, patrimônio e literatura."
  }
  dimension: subsetor {
    description: "Área de atuação no qual o projeto se inscreveu. Tais como: artes visuais, dança, circo, patrimônio e literatura."
  }

  dimension: perfil_publico {
    description: "Público alvo que pretende atender através do projeto (qualitativo)."
  }

  dimension: valor_projeto {}

}
