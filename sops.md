# SOPS

# Required tools

1. sops ( https://github.com/getsops/sops )
2. kustomize
3. ksops ( https://github.com/viaduct-ai/kustomize-sops )

## COMMANDS

remember to switch GCP config via gcloud configurations activate foo

```sh
sops -i --encrypt -gcp-kms "$KMS_PATH" -encrypted-regex '^(data)$' secret.yaml 
sops --decrypt foo

kustomize build --enable-alpha-plugins --enable-exec overlays/dev
```
