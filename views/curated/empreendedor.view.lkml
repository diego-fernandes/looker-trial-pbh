view: empreendedor {
  derived_table: {
    datagroup_trigger: pbh_data
    publish_as_db_view: yes

    sql:
      with inscrito as (
        select i.nu_inscricao, i.tp_empreendedor, i.no_empreendedor from trial-pbh.raw.tmp_lmic_inscrito i
        union all
        select i.nu_inscricao, i.tp_empreendedor, i.no_empreendedor from trial-pbh.raw.tmp_bhtelas_inscrito i
      )
      select
      FARM_FINGERPRINT(nome_norm) as pk
      ,*
      FROM (
        SELECT
            upper(regexp_replace(REGEXP_REPLACE(NORMALIZE(no_empreendedor, NFD), r"\pM", ''),r'[^\w\- ]|  +','')) as nome_norm
            ,upper(regexp_replace(no_empreendedor,r'[^\p{Latin}]|\n|  +','')) as nome
            ,trim(TIPO_EMPREEN) as tipo_empreendedor
            ,2020-IDADE as ano_nascimento
            --,IDADE -- mudar para ano de nascimento
            ,trim(EMPREEN_APROVOU_PROJETO_ANTES) as in_aprovou_projeto_antes
        FROM trial-pbh.raw.tmp_edtital_aprovado e
        join inscrito i
            on e.INSCRICAO=i.nu_inscricao
        where no_empreendedor is not null
        group by 1,2,3,4,5
      )
    ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
  }
  drill_fields: [pk]

  dimension: nome_norm {
    hidden: yes
  }

  dimension: nome {
    label: "Nome"
    type: string
    link: {
      label: "Pesquisar"
      url: "http://www.google.com/search?q={{ value | url_encode }}"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "Pesquisar Portal da Transparencia"
      url:   "https://portaldatransparencia.gov.br/pessoa-fisica/busca/lista?termo={{ value | url_encode }}&pagina=1&tamanhoPagina=10&favorecidoRecurso=true"
      icon_url: "http://google.com/favicon.ico"
    }
    link: {
      label: "Pesquisar CNPJ"
      url: "https://cnpj.linkana.com/busca?q={{ value | url_encode  }}&qo=t"
      icon_url: "data:image/png;base64,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"
    }
  }


  dimension: tipo_empreendedor {
    label: "Tipo"
    type: string
  }
  dimension: in_pessoa_fisica{
    label: "é CPF"
    type: yesno
    sql: if(${tipo_empreendedor}="PESSOA FÍSICA",true,false) ;;
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
    hidden: yes
    sql: 2020-${ano_nascimento} ;;
  }

  dimension: in_aprovou_projeto_antes {
    hidden: yes
  }

  dimension: aprovou_projeto {
    label: "já Aprovou Projeto?"
    type: yesno
    sql: if(${in_aprovou_projeto_antes}="SIM",true,false) ;;
  }


  measure: count {
    type: count
  }
}
