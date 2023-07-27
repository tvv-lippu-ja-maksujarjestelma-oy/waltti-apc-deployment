terraform {
  backend "gcs" {
    bucket = "waltti-streamnative-staging-tfstate"
    prefix = "terraform/state"
  }
}