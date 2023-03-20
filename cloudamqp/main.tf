# Create a new cloudamqp instance
resource "cloudamqp_instance" "instance" {
  name        = "dev-mqtt"
  plan        = "squirrel-1"
  region      = "google-compute-engine::${var.region}"
  tags        = ["dev"]
  rmq_version = "3.10.8"
}

# TODO: create loop with multiple notification emails!
resource "cloudamqp_notification" "recipient_01" {
  instance_id = cloudamqp_instance.instance.id
  type        = "email"
  value       = var.notification_email
  name        = "Default"
}

resource "cloudamqp_custom_domain" "settings" {
  instance_id = cloudamqp_instance.instance.id
  hostname    = "dev.mqtt.apc.lmj.fi"
}

resource "cloudamqp_security_firewall" "firewall_settings" {
  instance_id = cloudamqp_instance.instance.id

  rules {
    ip          = "0.0.0.0/0"
    services    = ["MQTTS"]
    description = "MQTTS"
  }

  dynamic "rules" {
    for_each = var.allowed_https_cidr
    content {
      ip          = rules.value
      services    = ["HTTPS"]
      description = "HTTPS"
    }

  }

}