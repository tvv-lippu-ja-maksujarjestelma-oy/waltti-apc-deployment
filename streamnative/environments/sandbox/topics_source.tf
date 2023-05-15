resource "pulsar_topic" "mqtt_apc_from_vehicle" {
  tenant     = pulsar_tenant.tenant.tenant
  namespace  = pulsar_namespace.source.namespace
  topic_type = "persistent"
  topic_name = "mqtt-apc-from-vehicle"
  partitions = 0

  permission_grant {
    role    = "proto-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }

}

resource "pulsar_topic" "gtfsrt_vp_fi_jyvaskyla" {
  tenant     = pulsar_tenant.tenant.tenant
  namespace  = pulsar_namespace.source.namespace
  topic_type = "persistent"
  topic_name = "gtfsrt-vp-fi-jyvaskyla"
  partitions = 0

  permission_grant {
    role    = "proto-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }

}
resource "pulsar_topic" "gtfsrt_vp_fi_kuopio" {
  tenant     = pulsar_tenant.tenant.tenant
  namespace  = pulsar_namespace.source.namespace
  topic_type = "persistent"
  topic_name = "gtfsrt-vp-fi-kuopio"
  partitions = 0

  permission_grant {
    role    = "proto-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }
}
