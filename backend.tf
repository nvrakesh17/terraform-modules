terraform {
  backend "gcs" {
    bucket = "terraform-gcs"
    prefix = "gke/${terraform.workspace}"
  }
}
