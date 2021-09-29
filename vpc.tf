resource "google_compute_network" "main_nw" {
  name = join("-", [var.service, "network"])
  depends_on = [
    google_project_service.service,
  ]

}

resource "google_compute_subnetwork" "main_subnet" {
  name          = join("-", [var.service, "subnetwork"])
  ip_cidr_range = "10.2.0.0/16"
  region        = "asia-northeast1"
  network       = google_compute_network.main_nw.id
  depends_on = [
    google_project_service.service,
  ]
}

