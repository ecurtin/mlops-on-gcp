#!/bin/bash

export PROJECT_ID="rsg-mlops-experimental-dev"
export SQL_PASSWORD="password123"
export DEPLOYMENT_NAME="mlflow-exp"
export REGION="us-central1"
export ZONE="us-central1-a"

export SQL_USERNAME="root"
# Set calculated infrastucture and folder names
export GCS_BUCKET_NAME="gs://$DEPLOYMENT_NAME-artifacts"
export ML_IMAGE_URI="gcr.io/$PROJECT_ID/$DEPLOYMENT_NAME-mlimage:latest"
