# GCP Project ID
variable "project_id" {
  description = "The ID of the Google Cloud project."
  type        = string
  default     = "value"
}

# Region for resources
variable "region" {
  description = "The region where resources will be deployed."
  type        = string
  default     = "us-central1"
}

# Storage bucket for raw data
variable "raw_data_bucket" {
  description = "The name of the Cloud Storage bucket for raw CSV data."
  type        = string
  default     = "medical_global_data"
}
