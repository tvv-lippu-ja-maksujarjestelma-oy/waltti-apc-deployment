terraform {
  backend "gcs" {
    bucket = "waltti-cloudamqp-sandbox-tfstate"
    prefix = "terraform/state"
  }
}