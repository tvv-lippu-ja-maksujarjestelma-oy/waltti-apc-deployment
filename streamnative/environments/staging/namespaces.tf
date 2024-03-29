# NOTE: the reource order matches APC Pulsar picture for easier reading!
resource "pulsar_namespace" "source" {
  namespace = "source"
  tenant    = pulsar_tenant.tenant.tenant

  retention_policies {
    # This is 32 days in minutes
    retention_minutes    = "46080"
    retention_size_in_mb = "-1"
  }
  permission_grant {
    role    = "staging-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }
}

resource "pulsar_namespace" "deduplicated" {
  namespace = "deduplicated"
  tenant    = pulsar_tenant.tenant.tenant

  retention_policies {
    retention_minutes    = "46080"
    retention_size_in_mb = "-1"
  }
  permission_grant {
    role    = "staging-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }

}

resource "pulsar_namespace" "cleaned" {
  namespace = "cleaned"
  tenant    = pulsar_tenant.tenant.tenant

  retention_policies {
    retention_minutes    = "46080"
    retention_size_in_mb = "-1"
  }
  permission_grant {
    role    = "staging-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }

}

resource "pulsar_namespace" "aggregated" {
  namespace = "aggregated"
  tenant    = pulsar_tenant.tenant.tenant

  retention_policies {
    retention_minutes    = "46080"
    retention_size_in_mb = "-1"
  }

  permission_grant {
    role    = "staging-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }

}

resource "pulsar_namespace" "anonymized" {
  namespace = "anonymized"
  tenant    = pulsar_tenant.tenant.tenant

  retention_policies {
    retention_minutes    = "46080"
    retention_size_in_mb = "-1"
  }
  permission_grant {
    role    = "staging-client@waltti.auth.streamnative.cloud"
    actions = ["produce", "consume", "functions"]
  }

}
