# Create a VPC network
resource "google_compute_network" "vpc_network" {
  name = var.network_name
  auto_create_subnetworks = false
}

# Create a subnet
resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = "10.0.0.0/16"
  region        = var.region
}

output "network_self_link" {
  value = google_compute_network.vpc_network.self_link
}

output "subnet_self_link" {
  value = google_compute_subnetwork.subnet.self_link
}
