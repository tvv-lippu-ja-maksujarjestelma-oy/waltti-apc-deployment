terraform {
  backend "gcs" {
    bucket = "waltti-mqtt-setup-staging-tfstate"
    prefix = "terraform/state"
  }
}