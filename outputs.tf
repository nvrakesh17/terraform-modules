output "firestore_collection" {
  description = "Firestore collection for Terraform state locking"
  value       = "terraform-lock"
}

output "gcs_bucket" {
  description = "GCS bucket for Terraform state storage"
  value       = google_storage_bucket.terraform_state.name
}
