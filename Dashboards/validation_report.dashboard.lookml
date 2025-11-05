- dashboard: validation_report
  title: "Validation Report"
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Shows rule validation results, failure patterns, and summary statistics."
  preferred_slug: validation_report_hin

  # Filters (applied across elements)
  filters:
  - name: rule_name
    title: "Rule Name"
    type: field_filter
    default_value: ""
    model: hca_hl7_deid_validation
    explore: validation_records
    field: validation_records.rule_name

  - name: status
    title: "Status"
    type: field_filter
    default_value: ""
    model: hca_hl7_deid_validation
    explore: validation_records
    field: validation_records.status

  - name: date
    title: "Validation Date"
    type: date_filter
    default_value: 30 days
    model: hca_hl7_deid_validation
    explore: validation_records
    field: validation_records.created_date

  # Dashboard tiles
  elements:

  - name: total_records
    title: "Total Records Validated"
    type: single_value
    model: hca_hl7_deid_validation
    explore: validation_records
    query:
      fields: [validation_records.total_records]
    row: 0
    col: 0
    width: 6
    height: 4

  - name: failed_records
    title: "Failed Records"
    type: single_value
    model: hca_hl7_deid_validation
    explore: validation_records
    query:
      fields: [validation_records.failed_records]
    row: 0
    col: 6
    width: 6
    height: 4

  - name: pass_rate
    title: "Pass Rate (%)"
    type: single_value
    model: hca_hl7_deid_validation
    explore: validation_records
    query:
      fields: [validation_records.pass_rate]
    row: 0
    col: 12
    width: 6
    height: 4

  - name: failures_by_rule
    title: "Failures by Rule"
    type: looker_bar
    model: hca_hl7_deid_validation
    explore: validation_records
    query:
      fields: [validation_records.rule_name, validation_records.failed_records]
      sorts: [validation_records.failed_records desc]
      limit: 10
      filters:
        validation_records.status: "Failed"
    row: 4
    col: 0
    width: 12
    height: 6

  - name: failure_trend
    title: "Failure Trend Over Time"
    type: looker_line
    model: hca_hl7_deid_validation
    explore: validation_records
    query:
      fields: [validation_records.created_date, validation_records.failed_records]
      sorts: [validation_records.created_date asc]
    row: 4
    col: 12
    width: 12
    height: 6

  - name: failure_table
    title: "Detailed Failure Records"
    type: looker_table
    model: hca_hl7_deid_validation
    explore: validation_records
    query:
      fields: [
        validation_records.record_id,
        validation_records.rule_name,
        validation_records.status,
        validation_records.error_message,
        validation_records.created_date
      ]
      sorts: [validation_records.created_date desc]
      limit: 50
    row: 10
    col: 0
    width: 24
    height: 8
