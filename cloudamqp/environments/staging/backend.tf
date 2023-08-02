terraform {
  backend "gcs" {
    bucket = "waltti-cloudamqp-staging-tfstate"
    prefix = "terraform/state"
  }
}