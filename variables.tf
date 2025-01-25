variable "project_id" {}
variable "region" {}
variable "cluster_name" {
  default = "gke-cluster"
}
variable "node_pool_name" {
  default = "default-pool"
}
variable "node_count" {
  default = 1
}
variable "machine_type" {
  default = "e2-micro"
}
variable "network_name" {
  default = "gke-network"
}
variable "subnet_name" {
  default = "gke-subnet"
}
