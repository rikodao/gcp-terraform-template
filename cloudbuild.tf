locals {
  branch = {
    prd = "main"
    dev = "develop"
  }
}
resource "google_cloudbuild_trigger" "cicd" {
  name = "cicd"
  trigger_template {
    branch_name = local.branch[terraform.workspace]
    repo_name   = "my-repo"
  }


  filename = "cloudbuild.yaml"
}