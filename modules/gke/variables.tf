variable "cluster_name" {}
variable "region" {}
variable "kubernetes_version" { default = "1.26.6-gke.1800" }
variable "initial_node_count" { default = 1 }
variable "machine_type" { default = "e2-medium" }
variable "disk_size" { default = 30 }
