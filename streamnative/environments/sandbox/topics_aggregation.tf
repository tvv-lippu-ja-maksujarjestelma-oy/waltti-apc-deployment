resource "pulsar_topic" "aggregated_apc_journey" {
  tenant     = pulsar_tenant.tenant.tenant
  namespace  = pulsar_namespace.aggregation.namespace
  topic_type = "persistent"
  topic_name = "aggregated-apc-journey"
  partitions = 0

  permission_grant {
    role    = "proto-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }
}

