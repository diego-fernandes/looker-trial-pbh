# The name of this view in Looker is "Tmp Lmic Inscricao"
view: tmp_lmic_inscricao {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `trial-pbh.raw.tmp_lmic_inscricao` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Empreendedor" in Explore.

  dimension: empreendedor {
    type: string
    sql: ${TABLE}.empreendedor ;;
  }

  dimension: inscricao {
    type: string
    sql: ${TABLE}.inscricao ;;
  }

  dimension: nome_projeto {
    type: string
    sql: ${TABLE}.nome_projeto ;;
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
