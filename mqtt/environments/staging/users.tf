module "mqtt_pulsar_forwarder" {
  source            = "../../../modules/mqtt-user"
  secretname        = "mqtt-pulsar-forwarder"
  vhost             = rabbitmq_vhost.apc.name
  topic_perms_read  = "^apc-from-vehicle\\.v[0-9][0-9]*\\.fi\\.waltti\\.testi\\..*$"
  topic_perms_write = "^apc-from-vehicle\\.v[0-9][0-9]*\\.fi\\.waltti\\.testi\\..*$"
}

module "pulsar_mqtt_forwarder" {
  source            = "../../../modules/mqtt-user"
  secretname        = "mqtt-pulsar-mqtt-forwarder"
  vhost             = rabbitmq_vhost.apc.name
  topic_perms_read  = "^apc\\.v[0-9][0-9]*\\.authority-id\\..*$"
  topic_perms_write = "^apc\\.v[0-9][0-9]*\\.authority-id\\..*$"
}

module "mqtt_waltti_rtpi" {
  source            = "../../../modules/mqtt-user"
  secretname        = "mqtt-waltti-rtpi"
  vhost             = rabbitmq_vhost.apc.name
  topic_perms_read  = "^anonymized-apc\\.v[0-9][0-9]*\\.authority-id\\..*$"
  topic_perms_write = "^$"
}

module "mqtt_waltti_raportointi" {
  source            = "../../../modules/mqtt-user"
  secretname        = "mqtt-waltti-raportointi"
  vhost             = rabbitmq_vhost.apc.name
  topic_perms_read  = "^apc\\.v[0-9][0-9]*\\.authority-id\\..*$"
  topic_perms_write = "^$"
}
