resource "google_service_account" "cloudamqp_logging" {
  account_id  = "cloudamp-logging"
  description = "CloudAMQP Logger"
}

resource "google_project_iam_member" "log_writer" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.cloudamqp_logging.email}"
}

resource "google_project_iam_member" "metric_writer" {
  project = var.project_id
  role    = "roles/monitoring.metricWriter"
  member  = "serviceAccount:${google_service_account.cloudamqp_logging.email}"
}


resource "google_service_account_key" "cloudamqp_key" {
  service_account_id = google_service_account.cloudamqp_logging.name
}

resource "cloudamqp_integration_log" "stackdriver" {
  instance_id = cloudamqp_instance.instance.id
  name        = "stackdriver"
  credentials = google_service_account_key.cloudamqp_key.private_key
}

resource "cloudamqp_integration_metric" "stackdriver" {
  instance_id = cloudamqp_instance.instance.id
  name        = "stackdriver"
  credentials = google_service_account_key.cloudamqp_key.private_key
}
