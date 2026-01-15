// GCP
variable "project_id" {
  default = "Project_ID"
}

variable "region" {
  default = "europe-west3"
}

variable "tf_service_account" {
}

// Pulsar
variable "web_service_url" {
  type = string
}

variable "broker_service_url" {
  type = string

}

variable "admin_roles" {
  type = string
}

// General
variable "environment" {
  default = "prod"
}

