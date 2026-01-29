# resource "google_project_service" "services" {
#   for_each = toset([
#     "run.googleapis.com",
#     "artifactregistry.googleapis.com",
#     "iam.googleapis.com",
#   ])
#   service            = each.value
#   disable_on_destroy = false
# }

resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = var.repo_id
  project = var.project_id
  format        = "DOCKER"
  description   = "Docker images for Cloud Run"
}

# Compte runtime du service (optionnel mais propre)
resource "google_service_account" "run_sa" {
  account_id   = "sa-cloudrun-django"
  display_name = "Cloud Run runtime SA"
  project = var.project_id

}

resource "google_cloud_run_v2_service" "service" {
  depends_on = [ google_artifact_registry_repository.repo]

  name     = var.service_name
  location = var.region
  project = var.project_id


  template {
    service_account = google_service_account.run_sa.email
    annotations = {
      "run.googleapis.com/ingress"              = "internal-and-cloud-load-balancing"
      "run.googleapis.com/vpc-access-egress"    = "all-traffic"
      "run.googleapis.com/binary-authorization" = "default"
    }
    containers {
      image = var.image

      ports {
        container_port = 8080
      }

      # Variables d'env (ex: Django)
      env {
        name  = "DJANGO_SETTINGS_MODULE"
        value = "app.settings"
      }

      # optionnel : ressources
      resources {
        limits = {
          cpu    = "1"
          memory = "512Mi"
        }
      }
    }
  }
}

# Public access (unauthenticated)
resource "google_cloud_run_v2_service_iam_member" "public" {
  location = google_cloud_run_v2_service.service.location
  name     = google_cloud_run_v2_service.service.name
  project = var.project_id
  role     = "roles/run.invoker"
  member   = "allUsers"
}

output "service_url" {
  value = google_cloud_run_v2_service.service.uri
}
