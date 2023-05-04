module "testuser" {
  source     = "../../../modules/mqtt-user"
  secretname = "mqtt-test-user"
  vhost      = rabbitmq_vhost.apc.name
}

module "mqtt_pulsar_forwarder" {
  source     = "../../../modules/mqtt-user"
  secretname = "mqtt-pulsar-forwarder"
  vhost      = rabbitmq_vhost.apc.name
}

