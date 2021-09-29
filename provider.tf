provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}

terraform {
  required_version = "1.0.7"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.85.0"
    }
  }
}
