#!/bin/bash

PROJECT_ID="your-gcp-project-id"
COLLECTION="terraform-lock"
DOCUMENT="global"

# Release lock
gcloud firestore documents update $DOCUMENT --project=$PROJECT_ID --collection=$COLLECTION --update="locked=false"
