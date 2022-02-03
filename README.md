# waltti-apc-deployment

Provision, configure and deploy the services for Waltti APC.

This repo is responsible for provisioning and configuring the infrastructure and deploying the services into the different environments.

Currently its a textual representation for what has been done in different management UIs but the way towards IaC has been given thought.
For example, CloudAMQP and GCP support `terraform import`.
StreamNative does offer a Terraform provider but not yet for GCP.

The Kubernetes deployment is pushed manually but can evolve towards Flux or something similar.
