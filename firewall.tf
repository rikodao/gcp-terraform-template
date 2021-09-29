resource "google_compute_firewall" "loadbalancer" {
  name          = "loadbalancer-firewall"
  network       = google_compute_network.main_nw.self_link
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  priority      = 1000

  allow {
    protocol = "tcp"
    ports    = [80, 8080]
  }
  depends_on = [
    google_project_service.service,
  ]
}


