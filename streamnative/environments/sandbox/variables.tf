// GCP
variable "project_id" {
  default = "Project_ID"
}

variable "region" {
  default = "europe-west3"
}

variable "tf_service_account" {
}

// StreamNative
variable "web_service_url" {
  type = string
}

variable "broker_service_url" {
  type = string

}
variable "client_id" {
  type = string
}

variable "issuer_url" {
  type = string
}

variable "key_file_path" {
  type = string
}

variable "audience" {
  type = string
}

variable "admin_roles" {
  type = string
}

// General
variable "environment" {
  default = "sandbox"
}