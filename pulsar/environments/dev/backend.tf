terraform {
  backend "gcs" {
    bucket = "waltti-pulsar-sandbox-tfstate"
    prefix = "terraform/state"
  }
}

