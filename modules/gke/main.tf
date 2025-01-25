resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.region
  network            = var.network
  subnetwork         = var.subnetwork
  initial_node_count = 1

  # Enable GKE features
  remove_default_node_pool = true
  min_master_version       = "1.31.4-gke.1183000"

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
}

# Create a node pool
resource "google_container_node_pool" "primary_nodes" {
  name       = var.node_pool_name
  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
    labels = {
      env = "dev"
    }
    tags = ["gke-node"]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  management {
    auto_upgrade = true
    auto_repair  = true
  }
}

output "endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "kubeconfig" {
  value = google_container_cluster.primary.endpoint
}
