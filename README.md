# ELT Data Pipeline with Cloud Run Functions

This project demonstrates how to automate an **ELT (Extract, Load, Transform)** data pipeline to process **1 million records** using **Google Cloud Run Functions**. The pipeline extracts data from Google Cloud Storage (GCS), loads it into BigQuery, and transforms it to create country-specific tables and views for analysis.

---

## Features

- Provision resources(data architecture) with Terraform.
- Upload data to Google Cloud Storage.
- Extract data from GCS in CSV format.
- Load raw data into a staging table in BigQuery.
- Transform data into country-specific tables and reporting views.
- Automate the entire workflow using Cloud Run Functions.
- Generate clean and structured datasets for analysis.

---

## Architecture

![image](https://github.com/Chisomnwa/ELT-Pipeline-with-GCP-and-Airflow/blob/main/project_files/data_pipeline_architecture.png)


### Workflow
1. **Extract**: Check for file existence in GCS.
2. **Load**: Load raw CSV data into a BigQuery staging table.
3. **Transform**:
   - Create country-specific tables in the transform layer.
   - Generate reporting views for each country with filtered insights.

### Data Layers
1. **Staging Layer**: Raw data from the CSV file.
2. **Transform Layer**: Cleaned and transformed tables.
3. **Reporting Layer**: Views optimized for analysis and reporting.

---

## Requirements

### Tools and Services
- **Terraform**:
  - For provisioning of data infrastructure
- **Google Cloud Platform (GCP)**:
  - Google Cloud Run Function
  - BigQuery
  - Cloud Storage

---

## Setup Instructions

### Prerequisites
1. Terraform Installed.
  - Use this [blog](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) for Terraform Installation on your local machine.
2. A Google Cloud project with:
   - BigQuery, Cloud Storage and Cloud Functions APIs enabled.
   - Because you will use Cloud Functions, also enable Cloud Build, Cloud Logging and Cloud Pub/Sub APIs.
   - Service account with required permissions.
3. Function Code which contains the logic for the workflow.

## End Result

### Looker Studio Report

![image](https://github.com/Chisomnwa/ELT-Pipeline-with-GCP-and-Airflow/blob/main/project_files/google_looker_studio_dashboard.png)

---
 ## Extra Resources
 - [Medium Article](https://medium.com/towards-data-engineering/elt-data-pipeline-with-gcp-and-apache-airflow-86c6d72544ef).
   