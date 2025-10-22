view: redaction_records {
  sql_table_name: `hca-data-lake-poc.validation_test_dataset.Redaction_Records` ;;

  # =========================
  # Dimensions
  # =========================

  dimension: redaction_uuid {
    primary_key: yes
    hidden: yes
    type: string
  }

  dimension: message_uuid { type: string }

  dimension: redaction_type {
    type: string
    description: "Type of redaction (e.g., NAME, ADDRESS, ID, etc.)"
  }

  dimension: confidence_score {
    type: number
    value_format_name: "decimal_2"
    description: "Confidence score from DLP redaction model."
  }

  dimension: original_count { type: number }
  dimension: redacted_count { type: number }

  dimension: is_pii {
    type: yesno
    description: "Indicates if the value is identified as PII."
  }

  dimension: sensitivity_level {
    type: string
    description: "Sensitivity level assigned to this redaction."
  }

  dimension_group: created {
    type: time
    timeframes: [raw, date, week, month, year]
    sql: ${TABLE}.created_timestamp ;;
  }

  # =========================
  # Measures
  # =========================

  measure: total_redactions {
    type: count
    drill_fields: [redaction_uuid, redaction_type, sensitivity_level]
    description: "Total number of redaction events."
  }

  measure: pii_redactions {
    type: count
    filters: [is_pii: "yes"]
    description: "Total number of records marked as PII."
  }

  measure: non_pii_redactions {
    type: count
    filters: [is_pii: "no"]
    description: "Total number of records not marked as PII."
  }

  measure: pii_rate {
    type: number
    sql: SAFE_DIVIDE(${pii_redactions}, NULLIF(${total_redactions}, 0)) ;;
    value_format_name: "percent_2"
    description: "Percentage of redactions identified as PII."
  }

  measure: avg_confidence {
    type: average
    sql: ${confidence_score} ;;
    description: "Average confidence across redactions."
  }

  measure: total_original_values {
    type: sum
    sql: ${original_count} ;;
    description: "Total number of original values before redaction."
  }

  measure: total_redacted_values {
    type: sum
    sql: ${redacted_count} ;;
    description: "Total number of redacted values."
  }

  measure: redaction_accuracy {
    type: number
    sql: SAFE_DIVIDE(${total_redacted_values}, NULLIF(${total_original_values}, 0)) ;;
    value_format_name: "percent_2"
    description: "Ratio of redacted values to original values."
  }

}
