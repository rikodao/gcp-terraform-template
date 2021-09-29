resource "google_compute_security_policy" "web_application_firewall" {
  name = join("-", [var.service, "waf"])

  rule {
    action   = "allow"
    priority = "2147483647"
    match {
      versioned_expr = "SRC_IPS_V1"
      config {
        src_ip_ranges = ["*"]
      }
    }
  }

  rule {
    action   = "deny(403)"
    priority = "1000"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('sqli-stable', ['owasp-crs-v030001-id942110-sqli', 'owasp-crs-v030001-id942120-sqli', 'owasp-crs-v030001-id942150-sqli', 'owasp-crs-v030001-id942180-sqli', 'owasp-crs-v030001-id942200-sqli', 'owasp-crs-v030001-id942210-sqli', 'owasp-crs-v030001-id942260-sqli', 'owasp-crs-v030001-id942300-sqli', 'owasp-crs-v030001-id942310-sqli', 'owasp-crs-v030001-id942330-sqli', 'owasp-crs-v030001-id942340-sqli', 'owasp-crs-v030001-id942380-sqli', 'owasp-crs-v030001-id942390-sqli', 'owasp-crs-v030001-id942400-sqli', 'owasp-crs-v030001-id942410-sqli', 'owasp-crs-v030001-id942430-sqli', 'owasp-crs-v030001-id942440-sqli', 'owasp-crs-v030001-id942450-sqli', 'owasp-crs-v030001-id942251-sqli', 'owasp-crs-v030001-id942420-sqli', 'owasp-crs-v030001-id942431-sqli', 'owasp-crs-v030001-id942460-sqli', 'owasp-crs-v030001-id942421-sqli', 'owasp-crs-v030001-id942432-sqli'] )||evaluatePreconfiguredExpr('xss-stable', ['owasp-crs-v030001-id941120-xss','owasp-crs-v030001-id941150-xss', 'owasp-crs-v030001-id941160-xss', 'owasp-crs-v030001-id941180-xss', 'owasp-crs-v030001-id941320-xss', 'owasp-crs-v030001-id941330-xss', 'owasp-crs-v030001-id941340-xss'] )"
      }
    }
  }
  depends_on = [
    google_project_service.service,
  ]
}