# The name of this view in Looker is "Tmp Edtital Aprovado"
view: tmp_edtital_aprovado {
  label: "Raw Edital Aprovado"
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `trial-pbh.raw.tmp_edtital_aprovado` ;;
  drill_fields: [inscricao]

  dimension: inscricao {
    group_label: "Projeto"
    group_item_label: "Inscrição"
    description: "Número de inscrição do projeto gerado pelo Mapa Cultural. Plataforma utilizada para gestão do espaço cultural pelo sistema de cultura."
    type: string
    sql: ${TABLE}.INSCRICAO ;;
    primary_key: yes
  }

    # Here's what a typical dimension looks like in LookML.
    # A dimension is a groupable field that can be used to filter query results.
    # This dimension will be called "Edital" in Explore.

  dimension: edital {
    group_label: "Projeto"
    group_item_label: "Edital"
    description: "Mecanismo no qual o projeto foi inscrito. No ano de 2020 houve o BH nas telas e LMIC."
    type: string
    sql: ${TABLE}.EDITAL ;;
  }

  dimension: r_empreen_aprovou_projeto_antes {
    hidden: yes
    type: string
    sql: ${TABLE}.EMPREEN_APROVOU_PROJETO_ANTES ;;
  }

  dimension: empreen_aprovou_projeto_antes {
    group_label: "Empreendedor"
    group_item_label: "Aprovou Projeto Antes ?"
    description: "Demonstra experiência prévia do empreendedor na inscrição de projetos."
    type: yesno
    sql: if(${r_empreen_aprovou_projeto_antes}="SIM",true,false);;
  }

  dimension: estimativa_publico {
    group_label: "Projeto"
    group_item_label: "Estimativa de Público"
    description: "Estimativa da quantidade de pessoas do público alvo que o projeto buscou atender."
    type: number
    sql: ${TABLE}.ESTIMATIVA_PUBLICO ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: sum_estimativa_publico {
    group_label: "Estimativa Público"
    group_item_label: "soma"
    type: sum
    sql: ${estimativa_publico} ;;
    }
  measure: avg_estimativa_publico {
    group_label: "Estimativa Público"
    group_item_label: "média"
    type: average
    sql: ${estimativa_publico} ;;
    }
  measure: min_estimativa_publico {
    group_label: "Estimativa Público"
    group_item_label: "mínimo"
    type: min
    sql: ${estimativa_publico} ;;
  }
  measure: max_estimativa_publico {
    group_label: "Estimativa Público"
    group_item_label: "máximo"
    type: max
    sql: ${estimativa_publico} ;;
  }


  dimension: idade {
    group_label: "Empreendedor"
    group_item_label: "Idade"
    description: "Idade do empreendedor."
    type: number
    sql: ${TABLE}.IDADE ;;
  }

  dimension: r_perfil_publico {
    hidden: yes
    sql: ${TABLE}.PERFIL_PUBLICO ;;
  }
  dimension: perfil_publico {
    group_label: "Projeto"
    group_item_label: "Perfil do público"
    description: "Público alvo que pretende atender através do projeto (qualitativo)."
    type: string
    sql: split(${r_perfil_publico},",") ;;
  }

  dimension: profissionais {
    group_label: "Projeto"
    group_item_label: "Profissionais contratados"
    description: "Número de contratações que são geradas com a execução do projeto."
    type: number
    sql: ${TABLE}.PROFISSIONAIS ;;
  }

  dimension: r_projeto_novo {
    hidden: yes
    type: string
    sql: ${TABLE}.PROJETO_NOVO ;;
  }
  dimension: projeto_novo {
    group_label: "Projeto"
    group_item_label: "Projeto novo?"
    description: "Indica se o projeto é inédito ou sua primeira edição."
    type: string
    sql: if(${r_projeto_novo}="SIM",true,false) ;;
  }

  dimension: setor {
    group_label: "Projeto"
    group_item_label: "Setor atuação"
    description: "Área de atuação no qual o projeto se inscreveu. Tais como: artes visuais, dança, circo, patrimônio e literatura."
    type: string
    sql: ${TABLE}.SETOR ;;
  }

  dimension: tipo_empreen {
    group_label: "Empreendedor"
    group_item_label: "Perfil empreendedor"
    description: "Perfil do empreendedor como pessoa física ou jurídica."
    type: string
    sql: ${TABLE}.TIPO_EMPREEN ;;
  }

  dimension: r_valor_aprovado {
    hidden: yes
    type: string
    sql: ${TABLE}.VALOR_APROVADO ;;
  }
  dimension: valor_aprovado {
    hidden: yes
    type: string
    sql: SAFE_CAST(REPLACE(${r_valor_aprovado},",",".") AS FLOAT64) ;;
  }

  measure: sum_valor_aprovado {
    group_label: "Valor Aprovado"
    group_item_label: "Soma"
    description: "Soma do valor contemplado pelo edital para o projeto."
    type: sum
    sql: ${valor_aprovado} ;;
  }
  measure: avg_valor_aprovado {
    group_label: "Valor Aprovado"
    group_item_label: "Média"
    description: "Média do valor contemplado pelo edital para o projeto."
    type: average
    sql: ${valor_aprovado} ;;
  }
  measure: max_valor_aprovado {
    group_label: "Valor Aprovado"
    group_item_label: "Maior"
    description: "Maior valor contemplado pelo edital para o projeto."
    type: average
    sql: ${valor_aprovado} ;;
  }
  measure: min_valor_aprovado {
    group_label: "Valor Aprovado"
    group_item_label: "Menor"
    description: "Menor valor contemplado pelo edital para o projeto."
    type: average
    sql: ${valor_aprovado} ;;
  }

  dimension: r_valor_projeto {
    hidden: yes
    type: string
    sql: ${TABLE}.VALOR_PROJETO ;;
  }
  dimension: valor_projeto {
    hidden: yes
    type: string
    sql: SAFE_CAST(REPLACE(${r_valor_projeto},",",".") AS FLOAT64) ;;
  }

  measure: sum_valor_projeto {
    group_label: "Valor Projeto"
    group_item_label: "Soma"
    description: "Soma do valor total do projeto (captação não exclusiva do edital)."
    type: sum
    sql: ${valor_projeto} ;;
  }
  measure: avg_valor_projeto {
    group_label: "Valor Projeto"
    group_item_label: "Média"
    description: "Média do valor total do projeto (captação não exclusiva do edital)."
    type: average
    sql: ${valor_projeto} ;;
  }
  measure: max_valor_projeto {
    group_label: "Valor Projeto"
    group_item_label: "Maior"
    description: "Maior valor total do projeto (captação não exclusiva do edital)."
    type: average
    sql: ${valor_projeto} ;;
  }
  measure: min_valor_projeto {
    group_label: "Valor Projeto"
    group_item_label: "Menor"
    description: "Menor valor total do projeto (captação não exclusiva do edital)."
    type: average
    sql: ${valor_projeto} ;;
  }

  dimension: r_valor_solicitado {
    hidden: yes
    type: string
    sql: ${TABLE}.VALORS_OLICITADO ;;
  }
  dimension: valor_solicitado {
    hidden: yes
    type: string
    sql: SAFE_CAST(REPLACE(${r_valor_solicitado},",",".") AS FLOAT64) ;;
  }

  measure: sum_valor_solicitado {
    group_label: "Valor Solicitado"
    group_item_label: "Soma"
    description: "Soma do valor que solicitado solicitou via edital para o projeto."
    type: sum
    sql: ${valor_solicitado} ;;
  }
  measure: avg_valor_solicitado {
    group_label: "Valor Solicitado"
    group_item_label: "Média"
    description: "Média do valor que solicitado solicitou via edital para o projeto."
    type: average
    sql: ${valor_solicitado} ;;
  }
  measure: max_valor_solicitado {
    group_label: "Valor Solicitado"
    group_item_label: "Maior"
    description: "Maior valor que solicitador solicitou via edital para o projeto."
    type: average
    sql: ${valor_solicitado} ;;
  }
  measure: min_valor_solicitado {
    group_label: "Valor Solicitado"
    group_item_label: "Menor"
    description: "Menor valor que solicitado via edital para o projeto."
    type: average
    sql: ${valor_solicitado} ;;
  }

  measure: count {
    label: "Contagem"
    type: count
  }
}
