# my-terraform-project/terragrunt.hcl

remote_state {
  backend = "s3"
  config = {
    bucket         = "terraform-state-keert"  # Replace with your S3 bucket name
    key            = "${path_relative_to_include()}/terraform.tfstate"  # Use relative path for state file
    region         = "ap-south-1"              # Change to your region
  }
}

# Include configuration for modules
include {
  path = find_in_parent_folders()
}