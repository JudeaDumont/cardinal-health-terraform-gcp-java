
resource "google_container_cluster" "primary" {
  name     = "my-gke-cluster"
  location = "us-east1"
  deletion_protection = false
  remove_default_node_pool = true

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 30
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  initial_node_count = 1
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  name       = "basic-small-node-pool"
  node_count = 1

  node_config {
    disk_size_gb = 30
    machine_type = "e2-medium"
  }
}