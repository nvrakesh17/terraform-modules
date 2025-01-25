variable "project_id" {}
variable "region" {}
variable "cluster_name" {}
variable "kubernetes_version" { default = "1.26.6-gke.1800" }
variable "network_name" {}
variable "subnet_name" {}
variable "ip_cidr_range" {}
variable "machine_type" { default = "e2-medium" }
variable "initial_node_count" { default = 1 }
variable "disk_size" { default = 30 }
