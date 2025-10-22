connection: "hca_hl7_deid"

include: "/views/**/*.view.lkml"

datagroup: hca_hl7_deid_validation_default_datagroup {
  max_cache_age: "1 hour"
}

persist_with: hca_hl7_deid_validation_default_datagroup

# Unified Explore
explore: redaction_records {
  label: "Validation - Redaction Records"
  description: "Explore showing PII redaction events, values, and message-level scores."

  join: redaction_messages {
    type: left_outer
    sql_on: ${redaction_records.message_uuid} = ${redaction_messages.message_uuid} ;;
    relationship: many_to_one
  }

  join: redaction_values {
    type: left_outer
    sql_on: ${redaction_records.redaction_uuid} = ${redaction_values.redaction_uuid} ;;
    relationship: one_to_many
  }
}
