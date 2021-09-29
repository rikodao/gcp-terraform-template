# locals {
#   warn_notification_channels=["projects/ca-kanauchi-test2/notificationChannels/2880407127317124823"]
#   critical_notification_channels=["projects/ca-kanauchi-test2/notificationChannels/16499439837114569654"]
# }

# resource "google_monitoring_alert_policy" "cpu-usage-warn" {
#   display_name          = "ca-kanauchi-test2 / GCE / CPU-Usage / Warning"
#   combiner     = "OR"
#   conditions {
#     display_name          = "ca-kanauchi-test2 / GCE / CPU-Usage / Warning"
#     condition_threshold {
#       filter     = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
#       duration   = "60s"
#       threshold_value = "50"
#       comparison = "COMPARISON_GT"
#       aggregations {
#         alignment_period   = "60s"
#       }
#     }
#   }
#   notification_channels = local.warn_notification_channels
# }

# resource "google_monitoring_alert_policy" "cpu-usage-critical" {
#   display_name          = "ca-kanauchi-test2 / GCE / CPU-Usage / Critical"
#   combiner     = "OR"
#   conditions {
#     display_name          = "ca-kanauchi-test2 / GCE / CPU-Usage / Critical"
#     condition_threshold {
#       filter     = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
#       duration   = "60s"
#       threshold_value = "90"
#       comparison = "COMPARISON_GT"
#       aggregations {
#         alignment_period   = "60s"
#       }
#     }
#   }
#   notification_channels = local.critical_notification_channels
# }

# resource "google_monitoring_alert_policy" "memory-usage-warning" {
#   display_name          = "ca-kanauchi-test2 / GCE / Memory-Usage / Warning"
#   combiner     = "OR"
#   conditions {
#     display_name          = "ca-kanauchi-test2 / GCE / Memory-Usage / Warning"
#     condition_threshold {
#       filter     = "metric.type=\"agent.googleapis.com/memory/percent_used\" AND resource.type=\"gce_instance\""
#       duration   = "60s"
#       threshold_value = "50"
#       comparison = "COMPARISON_GT"
#       aggregations {
#         alignment_period   = "60s"
#       }
#     }
#   }
#   notification_channels = local.warn_notification_channels
# }

# resource "google_monitoring_alert_policy" "memory-usage-critical" {
#   display_name          = "ca-kanauchi-test2 / GCE / Memory-Usage / Critical"
#   combiner     = "OR"
#   conditions {
#     display_name          = "ca-kanauchi-test2 / GCE / Memory-Usage / Critical"
#     condition_threshold {
#       filter     = "metric.type=\"agent.googleapis.com/memory/percent_used\" AND resource.type=\"gce_instance\""
#       duration   = "60s"
#       threshold_value = "90"
#       comparison = "COMPARISON_GT"
#       aggregations {
#         alignment_period   = "60s"
#       }
#     }
#   }
#   notification_channels = local.critical_notification_channels
# }

# resource "google_monitoring_alert_policy" "disk-usage-warning" {
#   display_name          = "ca-kanauchi-test2 / GCE / Disk-Usage / Warning"
#   combiner     = "OR"
#   conditions {
#     display_name          = "ca-kanauchi-test2 / GCE / Disk-Usage / Warning"
#     condition_threshold {
#       filter     = "metric.type=\"agent.googleapis.com/disk/percent_used\" AND resource.type=\"gce_instance\" AND metric.label.state!=\"free\""
#       duration   = "60s"
#       threshold_value = "80"
#       comparison = "COMPARISON_GT"
#       aggregations {
#         alignment_period   = "60s"
#       }
#     }
#   }
#   notification_channels = local.warn_notification_channels
# }

# resource "google_monitoring_alert_policy" "disk-usage-critical" {
#   display_name          = "ca-kanauchi-test2 / GCE / Disk-Usage / Critical"
#   combiner     = "OR"
#   conditions {
#     display_name          = "ca-kanauchi-test2 / GCE / Disk-Usage / Critical"
#     condition_threshold {
#       filter     = "metric.type=\"agent.googleapis.com/disk/percent_used\" AND resource.type=\"gce_instance\" AND metric.label.state!=\"free\""
#       duration   = "60s"
#       threshold_value = "90"
#       comparison = "COMPARISON_GT"
#       aggregations {
#         alignment_period   = "60s"
#       }
#     }
#   }
#   notification_channels = local.critical_notification_channels
# }

# resource "google_monitoring_alert_policy" "load-average-warning" {
#   display_name          = "ca-kanauchi-test2 / GCE / Load-Average / Warning"
#   combiner     = "OR"
#   conditions {
#     display_name          = "ca-kanauchi-test2 / GCE / Load-Average / Warning"
#     condition_threshold {
#       filter     = "metric.type=\"agent.googleapis.com/cpu/load_5m\" AND resource.type=\"gce_instance\""
#       duration   = "60s"
#       threshold_value = "1"
#       comparison = "COMPARISON_GT"
#       aggregations {
#         alignment_period   = "60s"
#       }
#     }
#   }
#   notification_channels = local.warn_notification_channels
# }

# resource "google_monitoring_alert_policy" "load-average-critical" {
#   display_name          = "ca-kanauchi-test2 / GCE / Load-Average / Critical"
#   combiner     = "OR"
#   conditions {
#     display_name          = "ca-kanauchi-test2 / GCE / Load-Average / Critical"
#     condition_threshold {
#       filter     = "metric.type=\"agent.googleapis.com/cpu/load_5m\" AND resource.type=\"gce_instance\""
#       duration   = "60s"
#       threshold_value = "2"
#       comparison = "COMPARISON_GT"
#       aggregations {
#         alignment_period   = "60s"
#       }
#     }
#   }
#   notification_channels = local.critical_notification_channels
# }

# resource "google_monitoring_uptime_check_config" "https-warn" {
#   display_name = "https-uptime-check"
#   timeout      = "1.5s"

#   http_check {
#     use_ssl = true
#     path = "/"
#     port = "443"
#   }

#   monitored_resource {
#     type = "uptime_url"
#     labels = {
#       project_id = "ca-kanauchi-test2"
#       host       = "ca-kanauchi-test.sandbox.cloud-ace.dev"
#     }
#   }
# }

# resource "google_monitoring_uptime_check_config" "https-critical" {
#   display_name = "https-uptime-check"
#   timeout      = "3.0s"

#   http_check {
#     use_ssl = true
#     path = "/"
#     port = "443"
#   }

#   monitored_resource {
#     type = "uptime_url"
#     labels = {
#       project_id = "ca-kanauchi-test2"
#       host       = "ca-kanauchi-test.sandbox.cloud-ace.dev"
#     }
#   }
# }
