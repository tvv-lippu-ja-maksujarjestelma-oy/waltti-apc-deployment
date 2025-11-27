# NOTE: it has to be imported via
# terraform import terraform import pulsar_cluster.cluster name_foo
# It tries to create a cluster but this provider does not have any 
# cloud settings etc for setting up a cluster
resource "pulsar_cluster" "cluster" {
  cluster = "pulsar"
  cluster_data {
    web_service_url    = var.web_service_url
    broker_service_url = var.broker_service_url
  }
}

resource "pulsar_tenant" "tenant" {
  tenant           = "apc-${var.environment}"
  admin_roles      = [var.admin_roles]
  allowed_clusters = [pulsar_cluster.cluster.cluster]
}

