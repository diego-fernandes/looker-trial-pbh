# Define the database connection to be used for this model.
connection: "trial-pbh"

label: "Editais Publicos"

# include all the views
include: "/views/raw/*.view.lkml"
include: "/views/curated/*.view.lkml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: pbh_data {
  sql_trigger: SELECT count(1) FROM trial-pbh.raw.tmp_edtital_aprovado;;
  max_cache_age: "1 hour"
}
persist_with: pbh_data

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Pbh Edital Atendimento"

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

# RAW Explore
explore: tmp_edtital_aprovado {
  label: "RAW - Atendimentos Editais Públicos "
}
explore: tmp_lmic_inscricao {
  label: "RAW - LMIC Inscricao "
}
explore: tmp_lmic_aprovados {
  label: "RAW - LMIC Aprovados "
}
explore: tmp_bhtelas_inscricao {
  label: "RAW - BH nas Telas Inscricao "
}
explore: tmp_bhnastelas_aprovados {
  label: "RAW - BH nas Telas Aprovados "
}

explore: projeto {
  label: "Projetos Apresentados"

  join: projeto_perfil_publico {
    view_label: "Perfils Publicos"
    sql: LEFT JOIN UNNEST(projeto.perfil_publico) as projeto_perfil_publico ;;
    relationship: one_to_many
  }

}
