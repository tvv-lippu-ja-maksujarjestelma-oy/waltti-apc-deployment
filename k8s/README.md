# Kubernetes

Run the Apache Pulsar clients and other software on Kubernetes Autopilot in GCP.
The region of the public cluster is `europe-west3`, like the StreamNative Cloud Hosted cluster.

Use [`sops`](https://github.com/mozilla/sops) with [`age`](https://github.com/FiloSottile/age) to encrypt any secrets.
The public keys are stored comma-separated in [`./sops-age-recipients`](./sops-age-recipients).

Each Kubernetes YAML file, excluding the secrets, contains one application.
The secrets are kept in separate files for using `sops` conveniently.

Kustomize is used to separate the environments.
