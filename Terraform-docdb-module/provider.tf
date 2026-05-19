terraform {
  backend "s3" {
    bucket  = "my-terraform-backend4321"
    key     = "backenddocdb/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
  required_version = ">=1.6.0"
}

provider "aws" {
  region = "us-east-1"
}