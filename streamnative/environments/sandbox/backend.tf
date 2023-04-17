terraform {
  backend "gcs" {
    bucket = "waltti-streamnative-sandbox-tfstate"
    prefix = "terraform/state"
  }
}