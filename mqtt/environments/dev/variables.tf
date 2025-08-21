// CloudAMQP
variable "cloudamqp_customer_api_key" {
  type      = string
  sensitive = true
}

// GCP
variable "project_id" {
  default = "Project_ID"
}

variable "region" {
  default = "europe-west3"
}

variable "tf_service_account" {
}

// RabbitMQ
variable "rabbitmq_endpoint" {
  type = string
}

variable "rabbitmq_username" {
  type = string
}

variable "rabbitmq_password" {
  type      = string
  sensitive = true
}

// General
variable "environment" {
  type    = string
  default = "sandbox"
}
