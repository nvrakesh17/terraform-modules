variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "firestore_location" {
  description = "Location for Firestore (e.g., us-central1)"
  type        = string
  default     = "us-central1"
}

variable "terraform_users" {
  description = "List of Terraform users allowed to modify Firestore locks"
  type        = list(string)
}
