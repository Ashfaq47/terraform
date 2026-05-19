terraform {
  backend "s3" {
    bucket = "my-terraform-backend4321"
    key     = "backend-RDS/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "RDS-state-lock"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=5.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}