view: edital {
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
          EDITAL  AS edital
          ,no_projeto numero_projeto
          ,cast(split(no_projeto,'/')[0] as int64) as nu_projeto
          ,cast(split(no_projeto,'/')[1] as int64) as ano_projeto
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

  dimension: edital {}
  dimension: numero_projeto {}
  dimension: nota {}

  dimension: valor_solicitado{}
  dimension: valor_aprovado{}

}
