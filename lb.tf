resource "google_compute_region_network_endpoint_group" "appengine_neg_web" {
  name                  = "appengine-neg-web"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  app_engine {
    service = "web"
  }
  depends_on = [
    google_project_service.service,
  ]

}
resource "google_compute_region_network_endpoint_group" "appengine_neg_api" {
  name                  = "appengine-neg-api"
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  app_engine {
    service = "api"
  }
  depends_on = [
    google_project_service.service,
  ]

}

resource "google_compute_backend_service" "gae_web_backendservice" {
  name            = "gae-web-backendservice"
  port_name       = "http"
  protocol        = "HTTP"
  security_policy = google_compute_security_policy.web_application_firewall.self_link
  backend {
    group = google_compute_region_network_endpoint_group.appengine_neg_web.id
  }
  depends_on = [
    google_project_service.service,
    google_compute_security_policy.web_application_firewall,
  ]

}

resource "google_compute_backend_service" "gae_api_backendservice" {
  name            = "gae-api-backendservice"
  port_name       = "http"
  protocol        = "HTTP"
  security_policy = google_compute_security_policy.web_application_firewall.self_link
  backend {
    group = google_compute_region_network_endpoint_group.appengine_neg_web.id
  }
  depends_on = [
    google_project_service.service,
    google_compute_security_policy.web_application_firewall,
  ]

}
resource "google_compute_url_map" "url-map" {
  name            = "url-map"
  default_service = google_compute_backend_service.gae_web_backendservice.self_link
  depends_on = [
    google_project_service.service,
  ]

}


resource "google_compute_global_address" "lb" {
  name = "lb"
}
resource "google_compute_managed_ssl_certificate" "ssl" {
  name = "ssl"
  managed {
    domains = ["ca-kanauchi-test.sandbox.cloud-ace.dev."]
  }
}

resource "google_compute_target_https_proxy" "target-https-proxy" {
  name             = "target-https-proxy"
  description      = "target-https-proxy"
  url_map          = google_compute_url_map.url-map.self_link
  ssl_certificates = [google_compute_managed_ssl_certificate.ssl.self_link]
}


resource "google_compute_global_forwarding_rule" "forwarding-rule-https" {
  name       = "forwarding-rule-https"
  target     = google_compute_target_https_proxy.target-https-proxy.self_link
  port_range = "443"
  ip_address = google_compute_global_address.lb.address
}

