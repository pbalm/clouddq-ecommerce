#!/bin/bash -x
wget -q -O clouddq_executable.zip https://github.com/GoogleCloudPlatform/cloud-data-quality/releases/download/v"${CLOUDDQ_RELEASE_VERSION}"/clouddq_executable_v"${CLOUDDQ_RELEASE_VERSION}"_"${TARGET_OS}"_python"${TARGET_PYTHON_INTERPRETER}".zip
python3 clouddq_executable.zip ALL config --gcp_project_id $GOOGLE_CLOUD_PROJECT --gcp_region_id $CLOUDDQ_BIGQUERY_REGION --gcp_bq_dataset_id $CLOUDDQ_BIGQUERY_DATASET --target_bigquery_summary_table $GOOGLE_CLOUD_PROJECT.$CLOUDDQ_BIGQUERY_DATASET.$CLOUDDQ_BIGQUERY_TARGET_TABLE
        