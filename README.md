# waltti-apc-deployment

Provision, configure and deploy the services for Waltti APC.

This repo is responsible for provisioning and configuring the infrastructure and deploying the services into the different environments.

Currently its a textual representation for what has been done in different management UIs but the way towards IaC has been given thought.
For example, CloudAMQP and GCP support `terraform import`.
StreamNative does offer a Terraform provider but not yet for GCP.

The Kubernetes deployment is pushed manually but can evolve towards Flux or something similar.

## CI

Every pull request and push to `main` runs [`scripts/ci/validate-manifests.sh`](scripts/ci/validate-manifests.sh): it renders every overlay under `manifests/` with kustomize, validates the output with kubeconform, and requires container images to be pinned by digest or an immutable `sha-<commit>` tag. CI has no sops key, so `scripts/ci/ksops` stands in for ksops and passes the encrypted Secrets through unchanged.

Pull requests from Argo CD Image Updater that only bump a dev overlay's image digest are auto-merged after validation ([`auto-merge-dev-images.yml`](.github/workflows/auto-merge-dev-images.yml)). staging and prod digests change only through a reviewed pull request: run [`scripts/promote-image.sh`](scripts/promote-image.sh) to copy a digest from dev to staging or from staging to prod, commit, and open the pull request.
