resource "pulsar_topic" "mqtt_from_vehicle_cleaned" {
  tenant     = pulsar_tenant.tenant.tenant
  namespace  = pulsar_namespace.cleaned.namespace
  topic_type = "persistent"
  topic_name = "mqtt-from-vehicle-cleaned"
  partitions = 0

  permission_grant {
    role    = "staging-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }

}

resource "pulsar_topic" "vehicle_anonymization_profile" {
  tenant     = pulsar_tenant.tenant.tenant
  namespace  = pulsar_namespace.cleaned.namespace
  topic_type = "persistent"
  topic_name = "vehicle-anonymization-profile"
  partitions = 0

  permission_grant {
    role    = "staging-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }

}