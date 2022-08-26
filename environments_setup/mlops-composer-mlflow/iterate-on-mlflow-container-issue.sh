#!/bin/bash

source actual-env-var.sh

MLFLOW_IMAGE_URI="gcr.io/${PROJECT_ID}/$DEPLOYMENT_NAME-mlflow"
gcloud builds submit mlflow-helm/docker --timeout 15m --tag ${MLFLOW_IMAGE_URI}:latest
helm uninstall mlflow -n mlflow
MLFLOW_PROXY_URI="gcr.io/${PROJECT_ID}/inverted-proxy"
CLOUD_SQL="$DEPLOYMENT_NAME-sql"
MLFLOW_SQL_CONNECTION_NAME=$(gcloud sql instances describe $CLOUD_SQL --format="value(connectionName)")
helm install mlflow --namespace mlflow --set images.mlflow=$MLFLOW_IMAGE_URI --set images.proxyagent=$MLFLOW_PROXY_URI --set defaultArtifactRoot=$GCS_BUCKET_NAME/experiments --set backendStore.mysql.host="127.0.0.1" --set backendStore.mysql.port="3306" --set backendStore.mysql.database="mlflow" --set backendStore.mysql.username=$SQL_USERNAME --set backendStore.mysql.password=$SQL_PASSWORD --set cloudSqlConnection.name=$MLFLOW_SQL_CONNECTION_NAME mlflow-helm
