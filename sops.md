# SOPS

## COMMANDS
remember to switch GCP config via gcloud configurations activate foo
sops -i --encrypt -gcp-kms $KMS_PATH -encrypted-regex '^(data)$' secret.yaml 
sops --decrypt foo