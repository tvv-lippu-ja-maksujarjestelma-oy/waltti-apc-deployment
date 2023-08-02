import click
import os
import json
from jsonschema import validate
import logging
from google.cloud import secretmanager

logging.basicConfig(level=os.environ.get("LOGLEVEL", "INFO"))
log = logging.getLogger(__name__)

secret_schema = {
    "type": "object",
    "properties": {
        "username": {"type": "string"},
        "vhost": {"type": "string"},
        "password": {"type": "string"},
    },
    "required": ["username", "vhost", "password"],
}


def validate_json(data):
    log.info("Validate json schema")
    validate(instance=data, schema=secret_schema)


def create_secret(secretname, secrettype, project_detail):
    log.info("Creating secret")
    client = secretmanager.SecretManagerServiceClient()
    secret = {"replication": {"automatic": {}}, "labels": {"secret_type": secrettype}}
    response = client.create_secret(
        secret_id=secretname, parent=project_detail, secret=secret
    )
    log.debug(response)
    return response


def create_secret_version(secretname,data,project_detail):
    log.info("Add payload")
    client = secretmanager.SecretManagerServiceClient()
    parent=f"{project_detail}/secrets/{secretname}"
    payload = json.dumps(data).encode("UTF-8")
    response = client.add_secret_version(parent=parent,payload={ "data": payload })
    log.debug(response)
    return response


@click.command(help="secret")
@click.option("--secrettype", "secrettype", default="mqtt")
@click.option("--secretfile", "secretfile", type=click.File(), default="secret.json")
@click.option("--secretname", "secretname")
@click.option("--project_id")

def main(project_id,secrettype, secretfile, secretname):
    project_id = project_id
    project_detail = f"projects/{project_id}"
    data = json.load(secretfile)
    log.debug(data)
    validate_json(data)
    create_secret(secretname, secrettype, project_detail)
    create_secret_version(secretname, data, project_detail)

if __name__ == "__main__":
    main()
