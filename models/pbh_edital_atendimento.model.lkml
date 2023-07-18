# Define the database connection to be used for this model.
connection: "trial-pbh"

label: "Edital Atendimento SMC"

# include all the views
include: "/views/raw/*.view.lkml"
include: "/views/curated/*.view.lkml"
include: "/dashboard/*.dashboard.lookml"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: pbh_data {
  sql_trigger: SELECT count(1) FROM trial-pbh.raw.tmp_edtital_aprovado;;
  max_cache_age: "12 hours"
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

explore: contrato {}

explore: projeto {
  label: "Projetos"

  join: projeto_perfil_publico {
    view_label: "Perfils Publicos"
    sql: LEFT JOIN UNNEST(projeto.perfil_publico) as projeto_perfil_publico WITH OFFSET as projeto_perfil_publico_offset;;
    relationship: one_to_many
  }

}

explore: empreendedor {
  label: "Empreendedor"
  join: contrato {
    sql_on: ${empreendedor.pk}=${contrato.empreendedor_fk} ;;
    relationship: one_to_many
  }
}

explore: inscricao_edital_aprovado {
  view_name: inscricao_edital
  sql_always_where: ${inscricao_edital.in_aprovado}=true ;;

  label: "Inscricao Edital"
  join: empreendedor {
    sql_on: ${inscricao_edital.fk_empeendedor}=${empreendedor.pk} ;;
    relationship: one_to_one
  }
  join: projeto {
    sql_on:  ${inscricao_edital.fk_projeto}=${projeto.pk} ;;
    relationship: one_to_one
  }
  join: projeto_perfil_publico {
    view_label: "Perfils Publicos"
    sql: LEFT JOIN UNNEST(projeto.perfil_publico) as projeto_perfil_publico WITH OFFSET as projeto_perfil_publico_offset;;
    relationship: one_to_many
  }
  join: contrato {
    sql_on: ${empreendedor.pk}=${contrato.empreendedor_fk} ;;
    relationship: one_to_many
  }

}

  explore: inscricao_edital_limc {
    view_name: inscricao_edital

    sql_always_where: ${inscricao_edital.edital_short}="LIMC" ;;

    label: "Inscricao Edital"
    join: empreendedor {
      sql_on: ${inscricao_edital.fk_empeendedor}=${empreendedor.pk} ;;
      relationship: one_to_one
    }
    join: projeto {
      sql_on:  ${inscricao_edital.fk_projeto}=${projeto.pk} ;;
      relationship: one_to_one
    }
    join: projeto_perfil_publico {
      view_label: "Perfils Publicos"
      sql: LEFT JOIN UNNEST(projeto.perfil_publico) as projeto_perfil_publico WITH OFFSET as projeto_perfil_publico_offset;;
      relationship: one_to_many
    }
    join: contrato {
      sql_on: ${empreendedor.pk}=${contrato.empreendedor_fk} ;;
      relationship: one_to_many
    }

  }


    explore: inscricao_edital_bhtelas {
      view_name: inscricao_edital

      sql_always_where: ${inscricao_edital.edital_short}="BH Nas Telas" ;;

      label: "Inscricao Edital"
      join: empreendedor {
        sql_on: ${inscricao_edital.fk_empeendedor}=${empreendedor.pk} ;;
        relationship: one_to_one
      }
      join: projeto {
        sql_on:  ${inscricao_edital.fk_projeto}=${projeto.pk} ;;
        relationship: one_to_one
      }
      join: projeto_perfil_publico {
        view_label: "Perfils Publicos"
        sql: LEFT JOIN UNNEST(projeto.perfil_publico) as projeto_perfil_publico WITH OFFSET as projeto_perfil_publico_offset;;
        relationship: one_to_many
      }
      join: contrato {
        sql_on: ${empreendedor.pk}=${contrato.empreendedor_fk} ;;
        relationship: one_to_many
      }

  }
