terraform {
  required_providers {
    pulsar = {
      version = "0.2.0"
      source  = "registry.terraform.io/streamnative/pulsar"
    }

    google = {
      source  = "hashicorp/google"
      version = "~> 4.75.0"

    }
  }
}

# Use GCP bucket for storing state
provider "google" {
  project                     = var.project_id
  region                      = var.region
  impersonate_service_account = var.tf_service_account

}

provider "pulsar" {
  web_service_url = var.web_service_url
  client_id       = var.client_id
  issuer_url      = var.issuer_url
  key_file_path   = var.key_file_path
  audience        = var.audience
}
