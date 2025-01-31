Terraform is an IAC tool, used primarily by DevOps teams to automate various infrastructure tasks. The provisioning of cloud resources, for instance, is one of the main use cases of Terraform. It's a cloud-agnostic, open-source provisioning tool written in the Go language and created by HashiCorp.



Create a Firestore Collection for Locking \

Go to the Firestore Database in the GCP Console \

Click "Start Collection" → Name it terraform-lock \

Add a document with:
Document ID: global (or a specific Terraform project name).
Field: locked → Boolean → false.
Field: timestamp → Timestamp → auto
