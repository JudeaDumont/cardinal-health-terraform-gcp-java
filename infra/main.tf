resource "google_storage_bucket" "website" {
  name = "static-website-by-jgd"
  location = "US"
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.website.name
  role = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket_object" "static_site_src" {
  name = "index.html"
  source = "../website/index.html"
  bucket = google_storage_bucket.website.name
}

resource "google_cloud_run_service" "simple_service" {
  name     = "springboot-service"
  location = "us-east1"

  template {
    spec {
      containers {
        image = "gcr.io/${var.gcp_project}/calculation-service:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_binding" "binding" {
  location = "us-east1"
  service  = google_cloud_run_service.simple_service.name
  role     = "roles/run.invoker"

  members = [
    "allUsers"
  ]
}

output "cloud_run_url" {
  value = google_cloud_run_service.simple_service.status[0].url
}
