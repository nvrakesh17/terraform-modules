provider "google" {
  project = var.project_id
  region  = var.region
}

module "network" {
  source        = "./modules/network"
  network_name  = var.network_name
  subnet_name   = var.subnet_name
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
}

module "gke" {
  source             = "./modules/gke"
  cluster_name       = var.cluster_name
  region             = var.region
  kubernetes_version = var.kubernetes_version
  initial_node_count = var.initial_node_count
  machine_type       = var.machine_type
  disk_size          = var.disk_size
}