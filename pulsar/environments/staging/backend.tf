terraform {
  backend "gcs" {
    bucket = "waltti-pulsar-staging-tfstate"
    prefix = "terraform/state"
  }
}


