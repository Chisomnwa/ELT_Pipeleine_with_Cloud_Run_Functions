# Import necessary libraries
from google.cloud import storage, bigquery
from google.cloud.bigquery import Table
import pandas as pd
import os
import io

BIGQUERY_PROJECT = os.getenv('BIGQUERY_PROJECT')

def process_csv(event, context):
    """Triggered by a file upload to Cloud Storage.
    Args:
        event (dict): Event payload.
        context (google.cloud.functions.Context): Metadata for the event.
    """

    # Extract event data
    bucket_name = event['bucket']
    file_name = event['name']

    # Initialize clients for Cloud Storage and BigQuery
    storage_client = storage.Client()
    bigquery_client = bigquery.Client()

    # Access the Cloud Storage bucket and file
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)

    # Download file content as a string
    file_content = blob.download_as_text()

    # Load file content into a Pandas DataFrame
    df = pd.read_csv(io.StringIO(file_content))

    # Normalize column names to lowercase
    df.columns = df.columns.str.lower()

    # Define BigQuery staging table ID
    staging_table_id = f"{BIGQUERY_PROJECT}.staging_dataset.raw_table"


    # Load raw data into the staging dataset
    bigquery_client.load_table_from_dataframe(df, staging_table_id).result()

    # Split data into country-specific tables in the transformed dataset
    countries = df['country'].unique()  # Use lowercase 'country' as the column name
    for country in countries:
        country_df = df[df['country'] == country]
        transformed_table_id = f"{BIGQUERY_PROJECT}.transformed_dataset.{country}_table"
        bigquery_client.load_table_from_dataframe(country_df, transformed_table_id).result()

        # Create views for reporting
        reporting_view_id = f"{BIGQUERY_PROJECT}.reporting_dataset.{country}_view"
        view_query = f"SELECT * FROM `{transformed_table_id}`"
        
        view = Table(reporting_view_id)
        view.view_query = view_query
        bigquery_client.create_table(view, exists_ok=True)

    print(f"File {file_name} processed successfully: staging, transformed, and reporting layers updated.")
