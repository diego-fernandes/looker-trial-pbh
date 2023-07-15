view: contrato {
  derived_table: {
    datagroup_trigger: pbh_data
    publish_as_db_view: yes

    sql:
      SELECT
      FARM_FINGERPRINT(ref_doc) pk
      ,trim(nome) as nome
      ,trim(ref_doc) as ref_doc
      ,trim(tipo_documento) as tp_documento
      FROM trial-pbh.raw.raw_contratos_smc
    ;;
  }

  dimension: pk {
    primary_key: yes
    hidden: yes
  }

  dimension: nome {}

  dimension: nome_emp {
    sql: trim(${nome},"e outros") ;;
    hidden: yes
  }

  dimension: ref_doc {
    type: string
    link: {
      label: "Acessar Documento"
      icon_url: "https://prefeitura.pbh.gov.br/sites/default/files/estrutura-de-governo/fundacao-municipal-de-cultura/transparencia/icone_PDF.png"
      url: "https://prefeitura.pbh.gov.br{{ value }}"
    }
  }
  dimension: tp_documento {
    label: "Tipo Documento"
    type: string
  }


}
