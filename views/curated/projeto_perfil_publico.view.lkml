view: projeto_perfil_publico {

  dimension: pk {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${projeto.pk} AS STRING),'|', CAST(${perfil_publico_offset} AS STRING)) ;;
  }
  drill_fields: [pk]

  dimension: perfil_publico_offset {
    hidden: yes
    sql: projeto_perfil_publico ;;
  }
  dimension: perfil_publico {
    label: "Nome Perfil"
    description: "Público alvo que pretende atender através do projeto (qualitativo)."
    sql: ${TABLE} ;;
  }

  measure: count {
    label: "Quantidade"
    type: count
  }


  measure: estivativa_publico_perfil {
    description: "Estimativa da quantidade de pessoas do público alvo que o projeto buscou atender por perfil publico."
    label: "Estimativa Público"
    type: sum
    sql: ROUND(${projeto.estimativa_publico}/${projeto.qtd_perfis}) ;;
    value_format: "#,##0"
  }

}
