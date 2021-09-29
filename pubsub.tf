locals {
  gae_endpoint = "https://10.10.10.10"
  endpoint = {
    tainyu = {
      dev = "https://10.10.10.10"
      stg = "https://10.10.10.10"
      prd = "https://10.10.10.10"
    }
    luline = {
      dev = "https://10.10.10.10"
      stg = "https://10.10.10.10"
      prd = "https://10.10.10.10"
    }
    lightbaito = {
      dev = "https://10.10.10.10"
      stg = "https://10.10.10.10"
      prd = "https://10.10.10.10"
    }
  }

  pubsub = {
    tainyu = {
      endpoint         = local.endpoint.tainyu[terraform.workspace]
      dead_letter_name = "tainyu-dead-letter"
    }
    luline = {
      endpoint         = local.endpoint.luline[terraform.workspace]
      dead_letter_name = "luline-dead-letter"

    }
    lightbaito = {
      endpoint         = local.endpoint.lightbaito[terraform.workspace]
      dead_letter_name = "lightbaito-dead-letter"
    }
  }
}

resource "google_pubsub_topic" "send_topic" {
  name = join("-", [var.service, "send", "topic"])
  depends_on = [
    google_project_service.service,
  ]
}

resource "google_pubsub_topic" "dead_letter" {
  for_each = local.pubsub
  name     = each.value.dead_letter_name
  depends_on = [
    google_project_service.service,
  ]
}

resource "google_pubsub_subscription" "send_subscription" {
  for_each = local.pubsub

  name  = join("-", [each.key, "subscription"])
  topic = google_pubsub_topic.send_topic.name

  ack_deadline_seconds = 20


  push_config {
    push_endpoint = each.value["endpoint"]
  }

  dead_letter_policy {
    dead_letter_topic     = google_pubsub_topic.dead_letter[each.key].id
    max_delivery_attempts = 10
  }
  depends_on = [
    google_project_service.service,
  ]
}


resource "google_pubsub_topic" "receive_topic" {
  name = join("-", [var.service, "receive", "topic"])
  depends_on = [
    google_project_service.service,
  ]
}

resource "google_pubsub_topic" "receive_dead_letter_topic" {
  name = join("-", [var.service, "-dead-letter"])
  depends_on = [
    google_project_service.service,
  ]
}

resource "google_pubsub_subscription" "receive_subscription" {

  name  = join("-", [var.service, "subscription"])
  topic = google_pubsub_topic.send_topic.name

  ack_deadline_seconds = 20


  push_config {
    push_endpoint = local.gae_endpoint
  }

  dead_letter_policy {
    dead_letter_topic     = google_pubsub_topic.receive_dead_letter_topic.id
    max_delivery_attempts = 10
  }
  depends_on = [
    google_project_service.service,
  ]
}
