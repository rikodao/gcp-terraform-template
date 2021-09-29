# 一度applyしたら、削除できないので、以降コメントアウトが必要
# resource "google_app_engine_application" "app" {
#   project     = var.project
#   location_id = var.region
#   depends_on = [
#     google_project_service.service,
#   ]
# }