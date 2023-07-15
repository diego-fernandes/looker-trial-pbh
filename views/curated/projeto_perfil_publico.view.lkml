view: projeto_perfil_publico {

  dimension: id {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${projeto.nu_projeto} AS STRING),'|', CAST(${perfil_publico_offset} AS STRING)) ;;
  }

  dimension: perfil_publico_offset {
    hidden: yes
    sql: projeto_perfil_publico ;;
  }
  dimension: perfil_publico {
    label: "Perfil Publico"
    description: "Público alvo que pretende atender através do projeto (qualitativo)."
    sql: ${TABLE} ;;
  }

  measure: count {
    type: count
  }

  measure: estivativa_publico_perfil {
    description: "Estimativa da quantidade de pessoas do público alvo que o projeto buscou atender por perfil publico."
    label: "Estimativa de pessoas aendidas por perfil"
    type: sum
    sql: ROUND(${projeto.estimativa_publico}/${projeto.qtd_perfis}) ;;
  }

}
