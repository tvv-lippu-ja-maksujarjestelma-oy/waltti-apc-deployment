resource "pulsar_topic" "mqtt_apc_from_vehicle_deduplicated" {
  tenant     = pulsar_tenant.tenant.tenant
  namespace  = pulsar_namespace.deduplicated.namespace
  topic_type = "persistent"
  topic_name = "mqtt-apc-from-vehicle-deduplicated"
  partitions = 0

  permission_grant {
    role    = "staging-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }
}