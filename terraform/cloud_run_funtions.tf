# Cloud Storage Bucket to store function code and trigger events
resource "google_storage_bucket" "bucket" {
  name     = "elt-functions-code-bucket"
  location = "US"

  versioning {
    enabled = true
  }

  force_destroy = true # Ensures bucket is deleted even if it contains objects
}

# Upload function code to function_code_bucket
resource "google_storage_bucket_object" "function_code" {
  name   = "function-code.zip"
  bucket = google_storage_bucket.bucket.name
  source = "./function-code.zip"
}

# Cloud Function configuration
resource "google_cloudfunctions_function" "csv_processor_function" {
  name        = "csv-processor-function"
  description = "Processes CSV files and uploads them to BigQuery"
  runtime     = "python310"

  available_memory_mb   = 2048
  timeout               = 540
  entry_point           = "process_csv" # Update to match your Python script's entry point function
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.function_code.name

  # Cloud Storage event trigger for CSV file uploads
  event_trigger {
    event_type = "google.storage.object.finalize"
    resource   = var.raw_data_bucket
  }

  environment_variables = {
    DATASET_NAME     = "staging_dataset" # Example variable for your dataset
    BIGQUERY_PROJECT = "data-engineering-447817"
  }

  labels = {
    environment = "dev"
  }
}
