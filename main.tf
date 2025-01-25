# Set provider
provider "google" {
  project = var.project_id
  region  = var.region
}

# Call the network module
module "network" {
  source      = "./modules/network"
  network_name = var.network_name
  subnet_name  = var.subnet_name
  region       = var.region
}

# Call the GKE module
module "gke" {
  source          = "./modules/gke"
  project_id      = var.project_id
  region          = var.region
  cluster_name    = var.cluster_name
  network         = module.network.network_self_link
  subnetwork      = module.network.subnet_self_link
  node_pool_name  = var.node_pool_name
  node_count      = var.node_count
  machine_type    = var.machine_type
}
