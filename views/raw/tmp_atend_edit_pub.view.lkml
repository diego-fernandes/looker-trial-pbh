# The name of this view in Looker is "Tmp Atend Edit Pub"
view: tmp_atend_edit_pub {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `raw.tmp_atend_edit_pub` ;;

  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Edital" in Explore.

  dimension: edital {
    type: string
    sql: ${TABLE}.EDITAL ;;
  }

  dimension: empren_j___aprovou_projeto_ {
    type: string
    sql: ${TABLE}.EMPREn_J___APROVOU_PROJETO_ ;;
  }

  dimension: estimativa_de_p__blico {
    type: number
    sql: ${TABLE}.ESTIMATIVA_DE_P__BLICO ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_estimativa_de_p__blico {
    type: sum
    sql: ${estimativa_de_p__blico} ;;  }
  measure: average_estimativa_de_p__blico {
    type: average
    sql: ${estimativa_de_p__blico} ;;  }

  dimension: idade {
    type: number
    sql: ${TABLE}.IDADE ;;
  }

  dimension: inscri____o {
    type: string
    sql: ${TABLE}.INSCRI____O ;;
  }

  dimension: perfil_de_p__blico {
    type: string
    sql: ${TABLE}.PERFIL_DE_P__BLICO ;;
  }

  dimension: profissionais {
    type: number
    sql: ${TABLE}.PROFISSIONAIS ;;
  }

  dimension: projeto_novo_ou_possui_hist__rico_ {
    type: string
    sql: ${TABLE}.PROJETO_NOVO_OU_POSSUI_HIST__RICO_ ;;
  }

  dimension: setor {
    type: string
    sql: ${TABLE}.SETOR ;;
  }

  dimension: tipo_empreen {
    type: string
    sql: ${TABLE}.TIPO_EMPREEN ;;
  }

  dimension: valor_aprovado {
    type: number
    sql: ${TABLE}.VALOR_APROVADO ;;
  }

  dimension: valor_projeto {
    type: number
    sql: ${TABLE}.VALOR_PROJETO ;;
  }

  dimension: valor_solicitado {
    type: number
    sql: ${TABLE}.VALOR_SOLICITADO ;;
  }

  measure: count {
    type: count
  }
}
