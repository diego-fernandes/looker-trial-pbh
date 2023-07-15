# The name of this view in Looker is "Raw Contratos Smc"
view: raw_contratos_smc {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `trial-pbh.raw.raw_contratos_smc` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Link" in Explore.

  dimension: link {
    type: string
    sql: ${TABLE}.link ;;
  }

  dimension: nome {
    type: string
    sql: ${TABLE}.nome ;;
  }

  dimension: orgao {
    type: string
    sql: ${TABLE}.orgao ;;
  }

  dimension: ref_doc {
    type: string
    sql: ${TABLE}.ref_doc ;;
  }

  dimension: tipo_documento {
    type: string
    sql: ${TABLE}.tipo_documento ;;
  }
  measure: count {
    type: count
  }
}
