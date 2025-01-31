#!/bin/bash

# 🚀 Terraform Wrapper for Firestore-based Locking & GCS State Management

PROJECT_ID="your-gcp-project-id"
COLLECTION="terraform-lock"
DOCUMENT="global"
COMMAND=$1  # Terraform command (plan, apply, destroy)

if [[ -z "$COMMAND" ]]; then
    echo "Usage: $0 <terraform-command>"
    exit 1
fi

# 🔐 Check if Terraform is locked
LOCKED=$(gcloud firestore documents get $DOCUMENT --project=$PROJECT_ID --collection=$COLLECTION --format="value(fields.locked.booleanValue)")

if [[ "$LOCKED" == "true" ]]; then
    echo "🚨 Terraform is already locked! Another process is running."
    exit 1
fi

# 🔒 Lock Terraform
echo "🔒 Locking Terraform state..."
gcloud firestore documents update $DOCUMENT --project=$PROJECT_ID --collection=$COLLECTION --update="locked=true,timestamp=$(date -u +'%Y-%m-%dT%H:%M:%SZ')"

# 🔄 Run Terraform Command
echo "🚀 Running Terraform $COMMAND..."
terraform init
terraform "$COMMAND"

# ❌ If Terraform fails, unlock state to avoid deadlocks
if [[ $? -ne 0 ]]; then
    echo "⚠️ Terraform $COMMAND failed! Unlocking state..."
    gcloud firestore documents update $DOCUMENT --project=$PROJECT_ID --collection=$COLLECTION --update="locked=false"
    exit 1
fi

# 🔓 Unlock Terraform
echo "🔓 Unlocking Terraform state..."
gcloud firestore documents update $DOCUMENT --project=$PROJECT_ID --collection=$COLLECTION --update="locked=false"

echo "✅ Terraform $COMMAND completed successfully!"
