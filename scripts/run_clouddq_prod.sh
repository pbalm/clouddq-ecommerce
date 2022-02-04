#!/bin/bash

gsutil cp gs://clouddq-prod-deployment/current/clouddq_executable.zip .
gsutil cp gs://clouddq-prod-deployment/current/config.zip .

unzip config

TARGET_OS=debian_11
TARGET_PYTHON_INTERPRETER='3.9'
CLOUDDQ_RELEASE_VERSION='0.5.1'
GOOGLE_CLOUD_PROJECT=clouddq-pbalm
CLOUDDQ_BIGQUERY_DATASET=ecommerce
CLOUDDQ_BIGQUERY_REGION=europe-west6
CLOUDDQ_BIGQUERY_TARGET_TABLE=data_quality_staging

python3 clouddq_executable.zip ALL config --gcp_project_id $GOOGLE_CLOUD_PROJECT --gcp_region_id $CLOUDDQ_BIGQUERY_REGION --gcp_bq_dataset_id $CLOUDDQ_BIGQUERY_DATASET --target_bigquery_summary_table $GOOGLE_CLOUD_PROJECT.$CLOUDDQ_BIGQUERY_DATASET.$CLOUDDQ_BIGQUERY_TARGET_TABLE
