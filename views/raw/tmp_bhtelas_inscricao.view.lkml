# The name of this view in Looker is "Tmp Bhtelas Inscricao"
view: tmp_bhtelas_inscricao {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `trial-pbh.raw.tmp_bhtelas_inscricao` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Categoria" in Explore.

  dimension: categoria {
    type: string
    sql: ${TABLE}.categoria ;;
  }

  dimension: dt_envio {
    type: string
    sql: ${TABLE}.dt_envio ;;
  }

  dimension: empreendedor {
    type: string
    sql: ${TABLE}.empreendedor ;;
  }

  dimension: hr_envio {
    type: string
    sql: ${TABLE}.hr_envio ;;
  }

  dimension: inscricao {
    type: string
    sql: ${TABLE}.inscricao ;;
  }

  dimension: no_projeto {
    type: string
    sql: ${TABLE}.no_projeto ;;
  }

  dimension: nu_projeto {
    type: string
    sql: ${TABLE}.nu_projeto ;;
  }

  dimension: tp_empreendedor {
    type: string
    sql: ${TABLE}.tp_empreendedor ;;
  }
  measure: count {
    type: count
  }
}
