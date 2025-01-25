output "cluster_endpoint" {
  value = module.gke.endpoint
}

output "kubeconfig" {
  value = module.gke.kubeconfig
}
