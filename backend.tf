terraform {
  backend "gcs" {
    bucket = "terraform-gcs"
    prefix = "terraform/state"  # Optional: Define a path for the state within the bucket
  }
}
