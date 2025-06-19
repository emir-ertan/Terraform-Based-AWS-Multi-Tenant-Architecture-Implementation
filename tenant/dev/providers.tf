##### Define Terraform State Backend and Must Providers
terraform {
  backend "s3" {
    bucket  = "tf-remote-backend-abc-985"
    key     = "proje/dev/infrastructure.tfstate"
    profile = "default"
    region  = "us-east-1"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.24.0"
    }
  }
}

##### Give Provider Credentials
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}