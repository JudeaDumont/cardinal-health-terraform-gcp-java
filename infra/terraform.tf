terraform {
  backend "gcs" {
    bucket = "terraform-state-bucket-x"
    prefix = "terraform/state"
    credentials = "keys/sa.json"
  }
}