# ---------------------------------------------------------------------------------------------------------------------
# ENABLED THE API SERVICE
# ---------------------------------------------------------------------------------------------------------------------

resource "google_project_service" "secretmanager" {
  service = "secretmanager.googleapis.com"
}

# ----------------------------------------------------------------------------------------
#     Create a random string 
# ----------------------------------------------------------------------------------------

resource "time_rotating" "sa_key_rotation" {
  rotation_minutes = 5
}

resource "random_string" "secret_value" {
  length  = 16
  special = true
  keepers = {
    rotation_time = time_rotating.sa_key_rotation.rotation_rfc3339
  }
}


# ----------------------------------------------------------------------------------------
#     Create a secret in GCP Secret Manager
# ----------------------------------------------------------------------------------------

resource "google_secret_manager_secret" "db_password_secret" {
  secret_id = "db-password-secret"

  labels = {
    secretmanager = "db_password"
  }

  replication {
    auto {}
  }
}

# ----------------------------------------------------------------------------------------
#     Create a version of our secret
# ----------------------------------------------------------------------------------------

resource "google_secret_manager_secret_version" "secret-version-basic" {
  secret      = google_secret_manager_secret.db_password_secret.id
  secret_data = random_string.secret_value.result
}

