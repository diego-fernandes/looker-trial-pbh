view: empreendedor {
  derived_table: {
    datagroup_trigger: pbh_data
    publish_as_db_view: yes

    sql:
      with inscrito as (
          select inscricao, tp_empreendedor, empreendedor from trial-pbh.raw.tmp_lmic_inscricao
          union all
          select inscricao, tp_empreendedor, empreendedor from trial-pbh.raw.tmp_bhtelas_inscricao
      )
      SELECT
          FARM_FINGERPRINT(empreendedor) as pk
          ,empreendedor as nome
          ,TIPO_EMPREEN as tipo_empreendedor
          ,2020-IDADE as ano_nascimento
          --,IDADE -- mudar para ano de nascimento
          ,EMPREEN_APROVOU_PROJETO_ANTES as in_aprovou_projeto_antes
      FROM trial-pbh.raw.tmp_edtital_aprovado e
      join inscrito i
          on e.INSCRICAO=i.inscricao
      group by 1,2,3,4
    ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
  }

  dimension: nome {
    label: "Nome"
    type: string
    link: {
      label: "Pesquisar Empeendedor"
      url: "http://www.google.com/search?q={{ value }}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "Investigar no Escavador"
      url: "https://www.escavador.com/busca?q={{ value }}&qo=t"
      icon_url: "https://www.escavador.com/assets/images/escavador.png"
    }
  }
  drill_fields: [pk]

  dimension: tipo_empreendedor {
    label: "Tipo"
    type: string
  }
  dimension: ano_nascimento {
    label: "Ano Nascimento"
    type: number
  }

  dimension: idade {
    label: "Idade"
    sql: extract(YEAR from current_date())-${ano_nascimento} ;;
  }
  dimension: idade_no_edital {
    sql: 2020-${ano_nascimento} ;;
  }

  dimension: in_aprovou_projeto_antes {}

  dimension: aprovou_projeto {
    label: "Já Aprovou Projeto?"
    type: yesno
    sql: if(${in_aprovou_projeto_antes}="SIM",true,false) ;;
  }


  measure: count {
    type: count
  }
}
