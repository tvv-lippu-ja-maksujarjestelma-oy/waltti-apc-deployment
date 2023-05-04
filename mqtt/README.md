# MQTT 

## TODO

1. Fix the clunky logic via conditional labels, see
https://stackoverflow.com/questions/62834938/google-cloud-how-to-grant-access-to-group-of-secrets-by-label-or-name


## username+password

Create a json secret in gcp in following format

{
    "username": "whatever",
    "password": "supa-secret"
}

The secret name is given via module, also access to mqtt service account needs to be granted.

Note: there is no json validation.


### CLI commands

gcloud secrets create "mqtt-test-user" \
    --replication-policy=automatic \
    --data-file=secret.json

gcloud secrets add-iam-policy-binding "mqtt-test-user" \
    --member="serviceAccount:SA_EMAIL_HERE" \
    --role="roles/secretmanager.secretAccessor"


gcloud secrets add-iam-policy-binding "mqtt-test-user" \
    --member="serviceAccount:SA_EMAIL_HERE" \
    --role="roles/secretmanager.viewer"
