Terraform workspaces allow you to maintain separate states for different environments while using the same configuration files. For example:

Workspace dev for the development environment.
Workspace staging for staging.
Workspace prod for production.



Initialize and switch workspaces:

terraform workspace new dev
terraform workspace new staging
terraform workspace new prod
terraform workspace select dev


Histroy
terraform init
terraform workspace select dev  # Or staging, prod
terraform apply -var-file=environment-specific/dev.tfvars
terraform workspace select staging
terraform apply -var-file=environment-specific/staging.tfvars
