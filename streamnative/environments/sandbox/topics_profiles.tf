resource "pulsar_topic" "vehicle_anonymization_profiles" {
  tenant     = pulsar_tenant.tenant.tenant
  namespace  = pulsar_namespace.source.namespace
  topic_type = "persistent"
  topic_name = "vehicle-anonymization-profiles"
  partitions = 0

  permission_grant {
    role    = "proto-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }

}