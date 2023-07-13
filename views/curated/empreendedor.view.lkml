view: empreendedor {
  derived_table: {
    sql:
    with inscrito as (
      select inscricao, tp_empreendedor, empreendedor from trial-pbh.raw.tmp_lmic_inscricao
      union all
      select inscricao, tp_empreendedor, empreendedor from trial-pbh.raw.tmp_bhtelas_inscricao
    )
      SELECT
        e.inscricao
        ,empreendedor as nome
        ,TIPO_EMPREEN as tipo_empreendedor
        ,EMPREEN_APROVOU_PROJETO_ANTES as in_aprovou_projeto_antes
        ,IDADE
      FROM trial-pbh.raw.tmp_edtital_aprovado e
      join inscrito i
        on e.INSCRICAO=i.inscricao
;;
  }

  dimension: inscricao {
    primary_key: yes
    type: string
  }
  drill_fields: [inscricao]
  dimension: empreendedor {
    type: string
  }
  dimension: tipo_empreendedor {
    type: string
  }
  dimension: IDADE {
    type: number
  }

  measure: count {
    type: count
  }
}
