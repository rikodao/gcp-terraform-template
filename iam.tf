
data "google_project" "project" {
  project_id = var.project
}

resource "google_project_service_identity" "cloudbuild_sa" {
  provider = google-beta

  project = data.google_project.project.project_id
  service = "cloudbuild.googleapis.com"
}



resource "google_project_iam_member" "hc_sa_bq_jobuser" {
  project = data.google_project.project.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_project_service_identity.cloudbuild_sa.email}"
}

resource "google_project_iam_member" "cloudbuild_service_agent_sa" {
  project = data.google_project.project.project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:service-${data.google_project.project.number}@gcp-sa-cloudbuild.iam.gserviceaccount.com"
  depends_on = [
    google_project_service.service,
  ]
}

resource "google_service_account" "web-app" {
  account_id   = "web-app"
  display_name = "web-app"
  depends_on = [
    google_project_service.service,
  ]
}

resource "google_project_iam_member" "web-app" {
  role   = "roles/editor"
  member = "serviceAccount:${google_service_account.web-app.email}"
  depends_on = [
    google_project_service.service,
  ]
}
