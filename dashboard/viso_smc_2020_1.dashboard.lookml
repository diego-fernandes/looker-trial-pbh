- dashboard: viso_smc_2020_1
  title: Visão SMC 2020
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  preferred_slug: UXYaXIHWbyLobNIxdBmOdh
  elements:
  - title: Untitled
    name: Untitled
    model: pbh_edital_atendimento
    explore: inscricao_edital_aprovado
    type: marketplace_viz_multiple_value::multiple_value-marketplace
    fields: [inscricao_edital.sum_valor_aprovado, inscricao_edital.sum_valor_solicitado]
    limit: 500
    column_limit: 50
    hidden_fields: []
    hidden_points_if_no: []
    show_view_names: false
    font_size_main: '22'
    orientation: auto
    style_inscricao_edital.sum_valor_aprovado: "#7CB342"
    show_title_inscricao_edital.sum_valor_aprovado: true
    title_placement_inscricao_edital.sum_valor_aprovado: above
    value_format_inscricao_edital.sum_valor_aprovado: ''
    show_comparison_inscricao_edital.sum_valor_solicitado: true
    comparison_style_inscricao_edital.sum_valor_solicitado: calculate_progress_perc
    comparison_show_label_inscricao_edital.sum_valor_solicitado: true
    comparison_label_placement_inscricao_edital.sum_valor_solicitado: below
    comp_value_format_inscricao_edital.sum_valor_solicitado: ''
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: true
    comparison_type: progress_percentage
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    comparison_label: Valor Solicitado
    hidden_pivots: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 0
    title_hidden: true
    listen: {}
    row: 2
    col: 0
    width: 15
    height: 5
  - title: Estimativa de Público
    name: Estimativa de Público
    model: pbh_edital_atendimento
    explore: inscricao_edital_aprovado
    type: single_value
    fields: [projeto.sum_estimativa_publico]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
    custom_color: "#1A73E8"
    single_value_title: Pessoas Atendidas
    value_format: 0.0,, "M "
    conditional_formatting: [{type: equal to, value: !!null '', background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    defaults_version: 1
    listen: {}
    row: 7
    col: 0
    width: 8
    height: 5
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: '<h1 style="text-align: center;">Visão Geral 2020</h1>'
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Untitled
    name: Untitled (2)
    model: pbh_edital_atendimento
    explore: inscricao_edital_aprovado
    type: looker_scatter
    fields: [projeto.setor, inscricao_edital.sum_valor_aprovado, projeto.sum_estimativa_publico,
      inscricao_edital.count]
    sorts: [inscricao_edital.sum_valor_aprovado desc 0]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - category: dimension
      expression: |+
        if(is_null(${projeto.subsetor}),
        ${projeto.setor},
        concat(${projeto.setor}," - ",${projeto.subsetor}))


      label: Setor E Subsetor
      value_format:
      value_format_name:
      dimension: setor_e_subsetor
      _kind_hint: dimension
      _type_hint: string
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: false
    y_axes: [{label: Público, orientation: bottom, series: [{axisId: projeto.sum_estimativa_publico,
            id: projeto.sum_estimativa_publico, name: Estimativa de Publico}], showLabels: true,
        showValues: true, valueFormat: '0, " K"', unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Valor
    size_by_field: inscricao_edital.count
    x_axis_zoom: true
    y_axis_zoom: true
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    label_value_format: ''
    series_point_styles:
      projeto.sum_estimativa_publico: auto
    x_axis_datetime_label: ''
    swap_axes: true
    cluster_points: false
    quadrants_enabled: true
    quadrant_properties:
      '0':
        color: "#fce6e3"
        label: Valor⇧ Publico⇩
      '1':
        color: ''
        label: Valor⇧ Publico⇧
      '2':
        color: ''
        label: Valor⇩ Publico⇩
      '3':
        color: "#d1ffe5"
        label: Valor⇩ Publico⇧
    custom_quadrant_point_x: 5
    custom_quadrant_point_y: 5
    custom_x_column: inscricao_edital.sum_valor_aprovado
    custom_y_column: projeto.sum_estimativa_publico
    custom_value_label_column: ''
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    arm_length: 25
    arm_weight: 50
    spinner_length: 100
    spinner_weight: 50
    angle: 90
    cutout: 50
    range_x: 1
    range_y: 1
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    hidden_fields:
    interpolation: linear
    value_labels: legend
    label_type: labPer
    hidden_points_if_no: []
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    title_hidden: true
    listen: {}
    row: 12
    col: 0
    width: 24
    height: 15
  - title: Profissionais Contratados
    name: Profissionais Contratados
    model: pbh_edital_atendimento
    explore: inscricao_edital_aprovado
    type: single_value
    fields: [projeto.sum_profissionais]
    limit: 500
    column_limit: 50
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    custom_color: "#1A73E8"
    defaults_version: 1
    listen: {}
    row: 7
    col: 8
    width: 7
    height: 5
  - title: Edital
    name: Edital
    model: pbh_edital_atendimento
    explore: inscricao_edital_aprovado
    type: marketplace_viz_spider::spider-marketplace
    fields: [inscricao_edital.edital_short, inscricao_edital.sum_valor_aprovado, projeto.sum_estimativa_publico,
      projeto.sum_profissionais]
    sorts: [inscricao_edital.sum_valor_aprovado desc 0]
    limit: 500
    column_limit: 50
    dynamic_fields:
    - args:
      - inscricao_edital.sum_valor_aprovado
      calculation_type: percent_of_column_sum
      category: table_calculation
      based_on: inscricao_edital.sum_valor_aprovado
      label: Percent of Inscricao Edital Valor Aprovado
      source_field: inscricao_edital.sum_valor_aprovado
      table_calculation: percent_of_inscricao_edital_valor_aprovado
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      _type_hint: number
    - args:
      - projeto.sum_estimativa_publico
      calculation_type: percent_of_column_sum
      category: table_calculation
      based_on: projeto.sum_estimativa_publico
      label: Percent of Projeto Estimativa de Publico
      source_field: projeto.sum_estimativa_publico
      table_calculation: percent_of_projeto_estimativa_de_publico
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      _type_hint: number
    - args:
      - projeto.sum_profissionais
      calculation_type: percent_of_column_sum
      category: table_calculation
      based_on: projeto.sum_profissionais
      label: Percent of Projeto Profissionais Contratados
      source_field: projeto.sum_profissionais
      table_calculation: percent_of_projeto_profissionais_contratados
      value_format:
      value_format_name: percent_0
      _kind_hint: measure
      _type_hint: number
    hidden_fields: [inscricao_edital.sum_valor_aprovado, projeto.sum_estimativa_publico,
      projeto.sum_profissionais]
    hidden_points_if_no: []
    show_view_names: false
    levels: 5
    label_factor: 85
    label_fine: 6
    rounded_strokes: true
    independent: false
    labelScale: true
    negatives: true
    wrap_width: 100
    opacity_area: 15
    dot_radius: 30
    opacity_circles: 15
    backgroundColor: "#CDCDCD"
    axisColor: "#CDCDCD"
    stroke_width: 15
    glow: 2
    axis_label_font: 12
    axis_scale_font: 12
    legend_font: 12
    legend_padding: 20
    legend_side: right
    LMIC_color: "#4A80BC"
    BH Nas Telas_color: "#615894"
    show_row_numbers: false
    transpose: true
    truncate_text: false
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: center
    header_font_size: '30'
    rows_font_size: '40'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#1A73E8",
        font_color: !!null '', color_application: {collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2,
          palette_id: 56d0c358-10a0-4fd6-aa0b-b117bef527ab}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    label_value: 'on'
    center_value: 'off'
    color_range: ["#4285F4", "#EA4335", "#FBBC04", "#34A852", "#5F6368"]
    font_size: 26
    label_size: 15
    color_by: root
    show_null_points: false
    value_format_override: ''
    show_percent: true
    arm_length: 25
    arm_weight: 50
    spinner_length: 100
    spinner_weight: 50
    angle: 90
    cutout: 50
    range_x: 1
    range_y: 1
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 0
    interpolation: linear
    value_labels: legend
    label_type: labPer
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: left
    percentType: total
    percentPosition: inline
    valuePosition: right
    labelColorEnabled: false
    labelColor: "#FFF"
    title_hidden: true
    row: 2
    col: 15
    width: 9
    height: 10
