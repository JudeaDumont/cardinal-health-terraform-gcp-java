resource "google_storage_bucket" "website" {
  name = "static-website-by-jgd"
  location = "US"
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.website.name
  role = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket_object" "static_site_src" {
  name = "index.html"
  source = "../website/index.html"
  bucket = google_storage_bucket.website.name
}
