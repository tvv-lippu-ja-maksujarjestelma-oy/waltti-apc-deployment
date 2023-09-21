// GCP
variable "project_id" {
  default = "gcp_project_id"
  type    = string
}

variable "region" {
  default = "europe-west3"
  type    = string
}

variable "tf_service_account" {
  type = string
}

// CloudAMQP
variable "cloudamqp_customer_api_key" {
  type = string
}

// General
variable "environment" {
  type = string
}

variable "allowed_https_cidr" {
}

variable "notification_email" {
  type = string
}

# NOTE: Updating rabbitmq via this variable is not working
variable "rabbitmq_version" {
  default = "3.12.4"
}