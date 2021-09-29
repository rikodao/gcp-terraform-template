locals {
  services = toset([
    "cloudbuild.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "iam.googleapis.com",
    "compute.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "pubsub.googleapis.com",
    "appengine.googleapis.com",
    "monitoring.googleapis.com",
    "logging.googleapis.com",
    "dns.googleapis.com",
    "bigquery.googleapis.com",
    "secretmanager.googleapis.com",
  ])
}

resource "google_project_service" "service" {
  for_each                   = local.services
  project                    = var.project
  service                    = each.value
  disable_dependent_services = true
}