#!/bin/bash

#
# set all needed variables
#

# if PROJECT_ID not already set, attempt to create unique project id
if ! [[ -v PROJECT_ID ]] ; then
	PROJECT_ID="challenge-lab-1-$(date +%m%d%y-%H%M)"
fi

# if BILLING_ACCOUNT_ID not already set, use the first available account
if ! [[ -v BILLING_ACCOUNT_ID ]] ; then
	BILLING_ACCOUNT_ID=$(gcloud beta billing accounts list | grep 'True' | awk '{print $1 }')
fi

# unique GCS bucket id based on project id
BUCKET_ID="$PROJECT_ID-bucket"

# unique GCE instance id (vm hostname) based on project id
INSTANCE_ID="$PROJECT_ID-instance-1"

# startup script path (local to cloud shell)
STARTUP_SCRIPT="$HOME/gcp-ace-labs/la-challenge-labs/1_gcp-and-gce/worker-startup-script.sh"

# API scopes, editted to allow write on Stackdriver and Storage APIs
SCOPES="https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/trace.append,https://www.googleapis.com/auth/devstorage.write_only"

#
# execute
#

# Create the new project
gcloud projects create --name "Challenge Lab One" "$PROJECT_ID"

# Setup project
gcloud config set project "$PROJECT_ID"
gcloud config set compute/region us-east1
gcloud config set compute/zone us-east1-d

# Link project to billing account
gcloud beta billing projects link "$PROJECT_ID" --billing-account="$BILLING_ACCOUNT_ID"

# create an unique GCS bucket
gsutil mb "gs://$BUCKET_ID"

# enable GCE compute api
gcloud services enable compute.googleapis.com

# deploy VM
gcloud beta compute instances create "$INSTANCE_ID"                     			\
				    --machine-type=f1-micro   			  		\
				    --metadata="lab-logs-bucket=gs://$BUCKET_ID/"		\
				    --metadata-from-file startup-script="$STARTUP_SCRIPT"	\
				    --scopes="$SCOPES"
