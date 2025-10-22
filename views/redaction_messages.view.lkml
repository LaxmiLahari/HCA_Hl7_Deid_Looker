view: redaction_messages {
  sql_table_name: `hca-data-lake-poc.validation_test_dataset.Redaction_Messages` ;;
  # primary_key: message_uuid

  dimension: message_uuid {
    primary_key: yes
    type: string
  }

  dimension: message_id {
    type: string
    description: "External or system-generated message ID."
  }

  dimension: message_score {
    type: number
    value_format_name: "decimal_2"
    description: "Overall score for the message (e.g., validation or DLP score)."
  }

  measure: total_messages {
    type: count
    description: "Total number of messages processed."
  }

  measure: avg_message_score {
    type: average
    sql: ${message_score} ;;
    description: "Average score of all processed messages."
  }

  measure: high_score_messages {
    type: count
    filters: [message_score: ">0.8"]
    description: "Number of messages with score > 0.8 (potentially clean messages)."
  }

  measure: low_score_messages {
    type: count
    filters: [message_score: "<0.5"]
    description: "Number of messages with score < 0.5 (potentially low quality)."
  }

}
