view: projeto_perfil_publico {

  dimension: id {
    primary_key: yes
    hidden: yes
    sql: CONCAT(CAST(${projeto.nu_projeto} AS STRING),'|', CAST(${perfil_publico} AS STRING)) ;;
  }

  dimension: perfil_publico {
    label: "Perfil Publico"
    description: "Público alvo que pretende atender através do projeto (qualitativo)."
  }

  measure: perfil_count {
    label: "Contagem de Perfil"
    type: count
  }


}
