resource "pulsar_topic" "anonymized_apc_journey" {
  tenant     = pulsar_tenant.tenant.tenant
  namespace  = pulsar_namespace.anonymized.namespace
  topic_type = "persistent"
  topic_name = "anonymized-apc-journey"
  partitions = 0

  permission_grant {
    role    = "proto-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }

}