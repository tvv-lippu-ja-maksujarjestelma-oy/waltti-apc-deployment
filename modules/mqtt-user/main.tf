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
    write     = var.user_perms_write
    read      = var.user_perms_read
  }
}

resource "rabbitmq_topic_permissions" "this_user" {
  user  = rabbitmq_user.this_user.name
  vhost = var.vhost

  permissions {
    exchange = "amq.topic"
    write    = var.topic_perms_write
    read     = var.topic_perms_read
  }
}
