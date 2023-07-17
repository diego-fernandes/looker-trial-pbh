# The name of this view in Looker is "Tmp Smccontrato Live"
view: tmp_smc_contrato_live {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `trial-pbh.raw.tmp_smc-contrato_live` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Doc Href" in Explore.

  dimension: doc_href {
    type: string
    sql: ${TABLE}.doc_href ;;
  }

  dimension: nome_doc {
    type: string
    sql: ${TABLE}.nome_doc ;;
  }
  measure: count {
    type: count
  }
}
