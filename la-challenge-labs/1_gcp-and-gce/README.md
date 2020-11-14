# acloudguru / Linux Academy - Google Certified Associate Cloud Engineer 2020
## Challenge Lab 1 - GCS & GCE

### Objective

+ Brand New GCP Project

+ GCE instance that runs provided worker script

+ System logs available in Stackdriver Logs

+ New GCS bucket for resulting log files

+ Log file appears in new bucket after instance finishes starting up

+ No need to SSH to instance

### How to Use

+ Clone this repository to the home directory of a GCP Cloud Shell machine

+ (Optional) export PROJECT_ID and BILLING_ACCOUNT_ID to your desired values (PROJECT_ID must be a unique, not-existent project)

+ Run ~/gcp-ace-labs/la-challenge-labs/1_gcp-and-gce/deploy.sh to build the environment

+ After a few minutes, look for a new log file in your bucket with gsutil or by visiting the Cloud Storage Browser in the GCP console. 

+ Run ~/gcp-ace-labs/la-challenge-labs/1_gcp-and-gce/destroy.sh to destroy the entire project.
