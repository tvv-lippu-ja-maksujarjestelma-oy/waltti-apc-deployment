terraform {
  required_providers {
    cloudamqp = {
      source = "cloudamqp/cloudamqp"

    }
    google = {
      source  = "hashicorp/google"
      version = "~> 4.75.0"

    }
  }

  required_version = "~> 1.3"

}

provider "cloudamqp" {
  apikey = var.cloudamqp_customer_api_key
}

provider "google" {
  project                     = var.project_id
  region                      = var.region
  impersonate_service_account = var.tf_service_account

}