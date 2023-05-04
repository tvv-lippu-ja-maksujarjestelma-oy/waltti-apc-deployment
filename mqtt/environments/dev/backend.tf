terraform {
  backend "gcs" {
    bucket = "waltti-mqtt-setup-sandbox-tfstate"
    prefix = "terraform/state"
  }
}