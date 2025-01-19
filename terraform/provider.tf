# # State the cloud provider you will be working with
# terraform {
#   required_providers {
#     google = {
#       source = "harshicorp/google"
#       version = "4.44.1"
#     }
#   }
# }

provider "google" {
  credentials = file("/Users/chisom/data-engineering-447817-269d83a2681d.json")
  project     = "data-engineering-447817"
  region      = "us-central1"
}
