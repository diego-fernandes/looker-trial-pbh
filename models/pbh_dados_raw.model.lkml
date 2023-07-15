# Define the database connection to be used for this model.
connection: "trial-pbh"

label: "Editais Publicos SMC"

# include all the views
include: "/views/raw/*.view.lkml"
include: "/views/curated/*.view.lkml"

datagroup: pbh_data {
  max_cache_age: "12 hours"
}
persist_with: pbh_data


# RAW Explore
explore: raw_contratos_smc {
  label: "RAW - Contratos SMC 2020 "
}
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
