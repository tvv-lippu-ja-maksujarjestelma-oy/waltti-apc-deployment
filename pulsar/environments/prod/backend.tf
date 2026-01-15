terraform {
  backend "gcs" {
    bucket = "waltti-apc-prod-tfstate"
    prefix = "pulsar/terraform/state"
  }
}

