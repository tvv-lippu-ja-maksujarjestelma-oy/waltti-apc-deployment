locals {
  mqtt_creds = jsondecode(
    data.google_secret_manager_secret_version.this_secret.secret_data
  )
}

data "google_secret_manager_secret_version" "this_secret" {
  secret = var.secretname
}

resource "rabbitmq_user" "this_user" {
  name     = local.mqtt_creds.username
  password = local.mqtt_creds.password
}

resource "rabbitmq_permissions" "this_user" {
  user  = rabbitmq_user.this_user.name
  vhost = var.vhost

  permissions {
    configure = "^([amq\\.topic].*)$"
    write     = "^([amq\\.topic].*)$"
    read      = "^([amq\\.topic].*)$"
  }
}

resource "rabbitmq_topic_permissions" "this_user" {
  user  = rabbitmq_user.this_user.name
  vhost = var.vhost

  permissions {
    exchange = "amq.topic"
    write    = ".*"
    read     = ".*"
  }
}
