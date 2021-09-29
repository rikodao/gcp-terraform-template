locals {
  dbname = join("-", [var.service, "db"])

  tier = {
    prd = "db-n1-standard-1"
    dev = "db-f1-micro"
  }
  availability_type = {
    prd = "REGIONAL"
    dev = "ZONAL"
  }
  deletion_protection = {
    prd = true
    dev = false
  }

  backup_configuration = {
    prd = 10
    dev = 2
  }
  maintenance_window = {
    update_track = {
      prd = "stable"
      dev = "canary"
    }
  }
}
resource "google_sql_database_instance" "application-database" {
  name             = local.dbname
  database_version = "MYSQL_8_0"
  region           = "asia-northeast1"

  depends_on          = [google_project_service.service]
  deletion_protection = local.deletion_protection[terraform.workspace]
  settings {
    tier              = local.tier[terraform.workspace]
    availability_type = local.availability_type[terraform.workspace]
    maintenance_window {
      day          = 7
      hour         = 0
      update_track = local.maintenance_window.update_track[terraform.workspace]
    }
    backup_configuration {
      enabled            = true
      start_time         = "00:00"
      binary_log_enabled = true
    }

    database_flags {
      name  = "slow_query_log"
      value = "on"
    }

  }
}


resource "google_sql_database" "voyage" {
  instance = google_sql_database_instance.voyage.name
  name     = "voyage"
}
