// CloudAMQP
variable "cloudamqp_endpoint" {
  type = string
}

variable "cloudamqp_username" {
  type = string
}

variable "cloudamqp_password" {
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

// General
variable "environment" {
  type    = string
  default = "sandbox"
}
