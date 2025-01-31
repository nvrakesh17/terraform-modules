#!/bin/bash

PROJECT_ID="your-gcp-project-id"
COLLECTION="terraform-lock"
DOCUMENT="global"

LOCKED=$(gcloud firestore documents get $DOCUMENT --project=$PROJECT_ID --collection=$COLLECTION --format="value(fields.locked.booleanValue)")

if [[ "$LOCKED" == "true" ]]; then
    echo "Terraform is already locked! Another process is running."
    exit 1
fi

# Set lock
gcloud firestore documents update $DOCUMENT --project=$PROJECT_ID --collection=$COLLECTION --update="locked=true,timestamp=$(date -u +'%Y-%m-%dT%H:%M:%SZ')"
