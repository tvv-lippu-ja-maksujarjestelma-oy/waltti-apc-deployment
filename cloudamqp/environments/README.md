# CloudAMQP MQTT broker

We use CloudAMQP to provide us with an MQTT broker.

CloudAMQP does have a Terraform provider.
It supports `terraform import`.
We might rely on that later on.

Instead, here is a step-by-step guide to provisioning and configuring our CloudAMQP MQTT broker through the UI.

## Provisioning and configuration

Sign up and log in at <https://customer.cloudamqp.com/>.

### Create team

From the UI:

> Each team you create will have separate billing. It's not possible to share instance access between team. You can however transfer ownership of instances between your teams.

1. Open the menu from top right.
1. Select "Create New Team".
1. Insert name "Waltti".
1. Read and agree to the Terms of Service.
1. Select Yes to "Will your use of this service be covered by the EU General Data Protection Regulation?"
1. Insert `info@lmj.fi` into "Contact details of your GDPR responsible".
1. Select "Create team".

### Configure team

1. Open the menu from top right.
1. Select "Team Settings".
1. Select "Team > Settings" from the left navigation bar.
1. Add "Team notification e-mail" for which the UI states
   > Please enter a generic business email address to whom CloudAMQP can send information of a technical nature, information about security breaches and information about urgent actions that might be required.
1. Set two-factor authentication.
1. Select "Team > Members" from the left navigation bar.
1. Add the relevant administrators from the button "Add member".

### Configure billing

1. Open the menu from top right.
1. Select "Billing".
1. Add Billing information.
1. Add Payment options.

### Create instance

One instance corresponds to one MQTT broker.

Probably one production instance is enough for all the needs of LMJ.
There might be several development instances.

Sassy Squirrel can only have 1 node, so no HA.

1. Go to <https://customer.cloudamqp.com/instance>.
1. Select "Create New Instance".
1. Add Name: "dev-mqtt"
1. Add Plan "Sassy Squirrel".
1. Add Tags: "dev". The UI states

   > Tags are used to separate your instances between projects. This is primarily used in the project listing view for easier navigation and access control. Tags allow admins to manage team members access to different groups of instances.

1. Select "Select Region".
1. Select Data center "europe-west1 (Belgium)" from Google Cloud. Unfortunately "europe-north1" (Finland) or "europe-west3" (StreamNative Cloud Hosted location in Europe) is not available.
1. Select "Review"
1. If everything looks swell, select "Create instance".

### Configure firewall

Many ports are open by default.
We only need MQTTS (8883) for the streaming events and HTTPS (443) for the management console.

1. In the CloudAMQP console, select "Firewall" from the left bar.
1. In the first row, add Description: "MQTTS and HTTPS only".
1. Add source IP space in [CIDR notation](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing#CIDR_notation).
1. Enable only MQTTS and HTTPS.
1. Select Save.

### Set custom domain

We wish for any future MQTT broker migration to be fairly painless.
Therefore we should own the domain that the APC systems connect to.

CloudAMQP should handle TLS via Let's Encrypt.

1. In the CloudAMQP console, select "Details" from the left bar.
1. Copy the load-balanced domain name from the Hosts section, e.g. `burly-gold-finch.rmq3.cloudamqp.com`.
1. In your DNS manager, create a CNAME record that points from `dev.mqtt.apc.lmj.fi` to the CloudAMQP domain name. Set a time-to-live of e.g. 600 seconds.
1. In the CloudAMQP console, select "Custom domain" from the left bar.
1. Add Custom Domain: `mqtt-dev.apc.waltti.fi`.
1. Select Create.

### Enable MQTT plugin

The MQTT plugin is not enabled by default.
Let's enable it.

**Note**:
It is important to set the custom domain before enabling the MQTT plugin.
Otherwise the TLS certificate offered from the MQTT endpoint for the custom domain is not valid.
If that happens, disabling and re-enabling the MQTT plugin helps.

1. In the CloudAMQP console, select "Plugins" from the left bar.
1. Enable "rabbitmq_mqtt".

### Create virtual host

Start from a clean slate instead of using the preconfigured virtual hosts.

The name of the virtual host will become part of all MQTT usernames.

1. In the RabbitMQ Manager, select tab "Admin".
1. Select "Virtual Hosts" from the right bar.
1. Select "Add a new virtual host".
1. Add Name "mqtt".
1. Add Description: "MQTT broker for development"
1. Add Tags: "dev"
1. Select "Add virtual host"

### Create users

Create the first MQTT user.

1. Select "Users" from the right bar.
1. Select "Add a user".
1. Add Username.
1. Add Password and confirm it by repetition.
1. Select Add user.

### Authorize user

Allow the user to publish and subscribe to certain MQTT topics.

1. Select the user, e.g. "test-user", by their name.
1. In the new page that opens, under Permissions, select Virtual Host "mqtt".
1. Add Configure regexp: `^([amq\.topic].*)$`
1. Add Write regexp: `^([amq\.topic].*)$`
1. Add Read regexp: `^([amq\.topic].*)$`
1. Select Set permission.
1. Under Topic permissions, select User.
1. Select Exchange: "amq.topic".
1. If the MQTT topic `<partner-id>` would be `foobar`, add Write regexp: `^apc-from-vehicle\.v[0-9][0-9]*\.fi\.waltti\.foobar\..*$`
1. If the MQTT topic `<partner-id>` would be `foobar`, add Read regexp: `^apc-from-vehicle\.v[0-9][0-9]*\.fi\.waltti\.foobar\..*$`
1. Select Set topic permission.
