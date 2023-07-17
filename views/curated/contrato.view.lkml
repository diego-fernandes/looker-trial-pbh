view: contrato {
  derived_table: {
    datagroup_trigger: pbh_data
    publish_as_db_view: yes

    sql:
      with contrato as (
      select doc_href,nome_doc_dedup as nome_doc
      ,upper(regexp_replace(REGEXP_REPLACE(NORMALIZE(nome_doc_dedup, NFD), r"\pM", ''),r'[^\w\- ]|  +','')) as nome_doc_norm
      FROM trial-pbh.raw.tmp_smc_contrato_live c
      join (
        select
        regexp_extract(doc_href,r'^.*(\d\d-\d\d\d-.*?)x*?.pdf') doc_raiz
        ,STRING_AGG(nome_doc,'') as nome_doc_dedup
        FROM trial-pbh.raw.tmp_smc_contrato_live
        group by 1) cr on cr.doc_raiz=regexp_extract(c.doc_href,r'^.*(\d\d-\d\d\d-.*?)x*?.pdf')
      )
      SELECT
      FARM_FINGERPRINT(doc_href) pk
      ,FARM_FINGERPRINT(REPLACE(regexp_extract(nome_doc_norm,r'(?:SMC -)\s*?(\b.*?\b)\s*?(?:-[^-]+TERMO.*$|-[^-]+\w*?$)')," E OUTROS", "")) empreendedor_fk
      ,doc_href
      ,nome_doc
      ,nome_doc_norm
      ,regexp_extract(nome_doc_norm,r'-([^-]+TERMO.*$|[^-]+\w*?$)') tp_documento
      --,regexp_extract(nome_doc_norm,r'(?:SMC -)\s*?(\b.*?\b)\s*?(?:-[^-]+TERMO.*$|-[^-]+\w*?$)') emp_documento
      FROM contrato c
      where doc_href is not null
    ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
  }

  dimension: empreendedor_fk {
    hidden: yes
  }

  dimension: doc_href {
    hidden: yes
    type: string
    link: {
      label: "Acessar Documento"
      icon_url: "https://prefeitura.pbh.gov.br/sites/default/files/estrutura-de-governo/fundacao-municipal-de-cultura/transparencia/icone_PDF.png"
      url: "https://prefeitura.pbh.gov.br{{ value }}"
    }
  }

  dimension: nome_doc {
    label: "Nome"
    type: string
    link: {
      label: "Acessar Documento"
      icon_url: "https://prefeitura.pbh.gov.br/sites/default/files/estrutura-de-governo/fundacao-municipal-de-cultura/transparencia/icone_PDF.png"
      url: "{{contrato.doc_href._value }}"
    }
  }
  dimension: nome_doc_norm {
    hidden: yes
  }
  dimension: emp_documento {
    hidden: yes
  }

  # dimension: nome_emp {
  #   sql: REPLACE(${emp_documento}," E OUTROS", "");;
  #   hidden: yes
  # }

  dimension: tp_documento {
    label: "Tipo Documento"
    type: string
  }


}
