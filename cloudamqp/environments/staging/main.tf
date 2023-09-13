# Create a new cloudamqp instance
resource "cloudamqp_instance" "instance" {
  name   = "${var.environment}-mqtt"
  plan   = "squirrel-1"
  region = "google-compute-engine::${var.region}"
  tags   = [var.environment]
  # TODO: test version changes!
  rmq_version = var.rabbitmq_version
}

resource "cloudamqp_plugin" "rabbitmq_mqtt" {
  instance_id = cloudamqp_instance.instance.id
  name        = "rabbitmq_mqtt"
  enabled     = true
}

# TODO: create loop with multiple notification emails!
resource "cloudamqp_notification" "recipient_01" {
  instance_id = cloudamqp_instance.instance.id
  type        = "email"
  value       = var.notification_email
  name        = "Default"
}

# NOTE: needs dns setup! 
# resource "cloudamqp_custom_domain" "settings" {
#   instance_id = cloudamqp_instance.instance.id
#   hostname    = "${var.environment}.mqtt.apc.lmj.fi"
# }

resource "cloudamqp_security_firewall" "firewall_settings" {
  instance_id = cloudamqp_instance.instance.id

  rules {
    ip          = "0.0.0.0/0"
    services    = ["MQTTS", "HTTPS"]
    description = "MQTTS"
  }

  # dynamic "rules" {
  #   for_each = var.allowed_https_cidr
  #   content {
  #     ip          = rules.value
  #     services    = ["HTTPS"]
  #     description = "HTTPS"
  #   }

  #}

}