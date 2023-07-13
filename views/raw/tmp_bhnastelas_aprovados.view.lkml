# The name of this view in Looker is "Tmp Bhnastelas Aprovados"
view: tmp_bhnastelas_aprovados {
  label: "Raw BH nas Telas Aprovado"
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `trial-pbh.raw.tmp_bhnastelas_aprovados` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Categoria" in Explore.

  dimension: categoria {
    type: number
    sql: ${TABLE}.categoria ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_categoria {
    type: sum
    sql: ${categoria} ;;  }
  measure: average_categoria {
    type: average
    sql: ${categoria} ;;  }

  dimension: empeendedor {
    type: string
    sql: ${TABLE}.empeendedor ;;
  }

  dimension: no_projeto {
    type: string
    sql: ${TABLE}.no_projeto ;;
  }

  dimension: nota {
    type: string
    sql: ${TABLE}.nota ;;
  }

  dimension: projeto {
    type: string
    sql: ${TABLE}.projeto ;;
  }

  dimension: valor_aprovado {
    type: string
    sql: ${TABLE}.valor_aprovado ;;
  }
  measure: count {
    type: count
  }
}
