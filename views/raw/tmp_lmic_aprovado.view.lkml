# The name of this view in Looker is "Tmp Lmicaprovado"
view: tmp_lmic_aprovado {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `trial-pbh.raw.tmp_lmic-aprovado` ;;

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

  dimension: nota {
    type: string
    sql: ${TABLE}.nota ;;
  }

  dimension: nu_projeto {
    type: string
    sql: ${TABLE}.nu_projeto ;;
  }

  dimension: setor {
    type: string
    sql: ${TABLE}.setor ;;
  }

  dimension: valor_aprovado {
    type: string
    sql: ${TABLE}.valor_aprovado ;;
  }
  measure: count {
    type: count
  }
}
