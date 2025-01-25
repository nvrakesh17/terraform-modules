cluster_name       = "prod-gke-cluster"
region             = "us-central1"
kubernetes_version = "1.26.6-gke.1800"
network_name       = "prod-vpc"
subnet_name        = "prod-subnet"
ip_cidr_range      = "10.0.3.0/24"
machine_type       = "e2-standard-4"
initial_node_count = 3

disk_size          = 50
