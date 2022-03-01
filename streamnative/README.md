# StreamNative Cloud Hosted

We use StreamNative Cloud Hosted to provide us with Apache Pulsar as PaaS.

StreamNative has several Terraform repositories on GitHub but none of them are for StreamNative Cloud Hosted on Google Cloud.

There exists a tool called `snctl` but due to the lack of documentation, the private nature of the GitHub repo and the lacking authorization to get anything done with our organization "superuser", we assume it is for internal use at StreamNative.

Instead, here is a step-by-step guide to provisioning and configuring our Apache Pulsar cluster through the UI.

## Provisioning and configuration

Sign up and log in here: <https://console.streamnative.cloud/>.

### Create organization

The name of the organization becomes part of the cluster URL.

Create the organization `waltti` if it does not exist.

### Invite teammates

Invite administrators by email.

### Create instance

The UI states

> Your Pulsar Instance determines your read and write costs, depending on your cloud provider or choice of single or multi-az. Your base cost is based on your soon-to-be created Pulsar Cluster.

Create:

1. name: waltti
1. provider: google
1. cluster type: standard
1. availability: multi az

### Create cluster

The name of the cluster becomes part of the cluster URL.
Let's create one cluster for the whole Waltti organization so that the Pulsar broker URL will become `pulsar+ssl://pulsar.waltti.snio.cloud:6651`.

Create:

1. Add Cluster Name: pulsar
1. Add Location: europe-west3 (Unfortunately europe-north1 is not offered as an option.)
1. Select Bookies: tiny-1
1. Select Bookie nodes: 3
1. Select Brokers: tiny-1
1. Select Broker nodes: 3
1. Select "please click here" under Features.
1. Enable Websocket.
1. Select Create Cluster.

### Create tenant

Different tenants do not automatically have access to each other's namespaces, topics and messages.
Tenants could be used to separate authorization per team or per project.

1. From the left bar, select Tenants.
1. Select New Tenant.
1. Add Tenants: apc-dev
1. Add Allowed Clusters: pulsar
1. Select Confirm.

### Create namespace

Namespaces could be seen as different parts of projects, or separate modules with their own event APIs or separate domains in the sense of domain-driven design.

Let's create a namespace for the MQTT messages from the vehicles.

1. From the left bar, select Tenants.
1. In the tenant overview, select the name of the tenant or the pen icon on the row "apc-dev" to edit the tenant.
1. Select the tab Namespaces.
1. Select New Namespace.
1. Add Name: source
1. Select Confirm.

### Create Service Account

Let's allow the service mqtt-pulsar-forwarder to connect to Pulsar.

1. From the left bar, select Service Accounts under Manage.
1. Select Create Service Account.
1. Add Name: mqtt-pulsar-forwarder
1. Select Confirm.
1. From the tab Oauth, you can download the OAuth 2.0 Key File for Oauth 2.0 client credentials flow.
1. Alternatively, from the tab Token, you can create a new expiring JWT token for authorization.

### Authorize Service Account

Let's allow the service mqtt-pulsar-forwarder to send messages into Pulsar.

1. From the left bar, select Namespaces.
1. Select Tenant: apc-dev
1. Select Namespace: source
1. In the tab Policy, select Authorization: mqtt-pulsar-forwarder@waltti.auth.streamnative.cloud
1. For Select Role, select: produce
