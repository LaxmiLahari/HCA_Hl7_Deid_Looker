view: redaction_values {
  sql_table_name: `hca-data-lake-poc.validation_test_dataset.Redaction_Values` ;;
  # primary_key: redaction_uuid

  dimension: redaction_uuid {
    primary_key: yes
    type: string
  }

  dimension: original_value {
    type: string
    description: "Original unredacted value detected by DLP."
  }

  measure: value_count {
    type: count
    description: "Number of values associated with redaction UUIDs."
  }

  measure: distinct_values {
    type: count_distinct
    sql: ${original_value} ;;
    description: "Count of unique original values redacted."
  }
}
