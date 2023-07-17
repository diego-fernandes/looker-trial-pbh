# The name of this view in Looker is "Tmp Lmicinscrito"
view: tmp_lmic_inscrito {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `trial-pbh.raw.tmp_lmic-inscrito` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "No Empreendedor" in Explore.

  dimension: no_empreendedor {
    type: string
    sql: ${TABLE}.no_empreendedor ;;
  }

  dimension: no_projeto {
    type: string
    sql: ${TABLE}.no_projeto ;;
  }

  dimension: nu_inscricao {
    type: string
    sql: ${TABLE}.nu_inscricao ;;
  }

  dimension: nu_projeto {
    type: string
    sql: ${TABLE}.nu_projeto ;;
  }

  dimension: setor {
    type: string
    sql: ${TABLE}.setor ;;
  }

  dimension: setor_analise {
    type: string
    sql: ${TABLE}.setor_analise ;;
  }

  dimension: tp_empreendedor {
    type: string
    sql: ${TABLE}.tp_empreendedor ;;
  }
  measure: count {
    type: count
  }
}
