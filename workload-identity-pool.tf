resource "google_iam_workload_identity_pool" "employee" {
  provider                  = google-beta
  workload_identity_pool_id = "employee"
}