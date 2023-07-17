# Define the database connection to be used for this model.
connection: "trial-pbh"

label: "Análise dados RAW"

# include all the views
include: "/views/raw/*.view.lkml"
include: "/views/curated/*.view.lkml"

datagroup: pbh_data {
  max_cache_age: "12 hours"
}
persist_with: pbh_data


# RAW Explore
explore: tmp_bhtelasaprovado {}
explore: tmp_bhtelasinscrito {}
explore: tmp_edtital_aprovado {}
explore: tmp_lmic_aprovado {}
