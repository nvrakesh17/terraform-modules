resource "google_container_cluster" "gke_cluster" {
  name               = var.cluster_name
  location           = var.region
  initial_node_count = var.initial_node_count

  node_config {
    machine_type = var.machine_type
    disk_size_gb = var.disk_size
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  min_master_version = var.kubernetes_version

  lifecycle {
    prevent_destroy = true
  }
}
