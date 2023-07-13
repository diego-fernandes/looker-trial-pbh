view: projeto {
  # derived_table: {
  #   explore_source: tmp_edtital_aprovado {
  #     column: edital {}
  #     column: estimativa_publico {}
  #     column: inscricao {}
  #     column: perfil_publico {}
  #     column: profissionais {}
  #     column: projeto_novo {}
  #     column: setor {}
  #   }
  # }

  derived_table: {
    sql:
    with projeto as (
      select inscricao, nu_projeto, nome_projeto, setor, setor_analise from trial-pbh.raw.tmp_lmic_inscricao
      union all
      select inscricao, nu_projeto, no_projeto, "AUDIOVISUAL", null from trial-pbh.raw.tmp_bhtelas_inscricao
    )
      SELECT
        nu_projeto as numero_projeto
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
            ,case
          when CONTAINS_SUBSTR(p.setor,'(') then trim(split(p.setor,'(')[0])
          else p.setor
        end as setor_inscricao
        ,case
          when CONTAINS_SUBSTR(p.setor,'(') then trim(split(p.setor,'(')[0])
          else null
        end as subsetor_inscricao
        ,SAFE_CAST(REPLACE(VALOR_PROJETO,",",".") AS FLOAT64) AS VALOR_PROJETO
      FROM trial-pbh.raw.tmp_edtital_aprovado e
      join projeto p on e.INSCRICAO=p.inscricao
;

    ;;

  }

  dimension: numero_projeto {}
  dimension: nome_projeto {}
  dimension: estimativa_publico {
    label: "Raw Edital Aprovado Estimativa Publico"
    description: "Estimativa da quantidade de pessoas do público alvo que o projeto buscou atender."
    type: number
  }
  dimension: profissionais {
    label: "Raw Edital Aprovado Profissionais"
    description: "Número de contratações que são geradas com a execução do projeto."
    type: number
  }
  dimension: projeto_novo {
    label: "Raw Edital Aprovado Projeto Novo"
    description: "Indica se o projeto é inédito ou sua primeira edição."
  }
  dimension: setor {
    label: "Raw Edital Aprovado Setor"
    description: "Área de atuação no qual o projeto se inscreveu. Tais como: artes visuais, dança, circo, patrimônio e literatura."
  }
  dimension: subsetor {
    label: "Raw Edital Aprovado Setor"
    description: "Área de atuação no qual o projeto se inscreveu. Tais como: artes visuais, dança, circo, patrimônio e literatura."
  }
  dimension: setor_inscricao {
    label: "Raw Edital Aprovado Setor"
    description: "Área de atuação no qual o projeto se inscreveu. Tais como: artes visuais, dança, circo, patrimônio e literatura."
  }
  dimension: subsetor_inscricao {
    label: "Raw Edital Aprovado Setor"
    description: "Área de atuação no qual o projeto se inscreveu. Tais como: artes visuais, dança, circo, patrimônio e literatura."
  }

  dimension: edital {
    label: "Raw Edital Aprovado Edital"
    description: "Mecanismo no qual o projeto foi inscrito. No ano de 2020 houve o BH nas telas e LMIC."
  }

  dimension: inscricao {
    label: "Raw Edital Aprovado Inscricao"
    description: "Número de inscrição do projeto gerado pelo Mapa Cultural. Plataforma utilizada para gestão do espaço cultural pelo sistema de cultura."
  }

  dimension: perfil_publico {
    label: "Raw Edital Aprovado Perfil Publico"
    description: "Público alvo que pretende atender através do projeto (qualitativo)."
  }



}
