provider "google" {
  project = var.project_id
}

# 🔹 Enable Firestore in Native Mode
resource "google_firestore_database" "firestore" {
  project     = var.project_id
  name        = "(default)"
  location_id = var.firestore_location
  type        = "FIRESTORE_NATIVE"
}

# 🔹 Create Firestore Collection for Locking
resource "google_firestore_document" "terraform_lock" {
  project     = var.project_id
  database    = google_firestore_database.firestore.name
  collection  = "terraform-lock"
  document_id = "global"

  fields = <<EOT
  {
    "locked": { "booleanValue": false },
    "timestamp": { "timestampValue": "1970-01-01T00:00:00Z" }
  }
  EOT
}

# 🔹 Create GCS Bucket for Terraform State Storage
resource "google_storage_bucket" "terraform_state" {
  name          = "${var.project_id}-terraform-state"
  location      = var.gcs_location
  force_destroy = false

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 365
    }
  }
}

# 🔹 IAM Role: Allow Terraform to Manage State
resource "google_storage_bucket_iam_binding" "terraform_state_binding" {
  bucket = google_storage_bucket.terraform_state.name
  role   = "roles/storage.admin"

  members = var.terraform_users
}

# 🔹 IAM Role: Allow Firestore Lock Management
resource "google_project_iam_binding" "firestore_iam" {
  project = var.project_id
  role    = "roles/datastore.user"

  members = var.terraform_users
}
