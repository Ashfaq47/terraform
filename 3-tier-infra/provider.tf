terraform {
  backend "s3" {
    bucket  = "my-terraform-backend4321"
    region  = "us-east-1"
    encrypt = true
    key     = "backend/terraform.tfstate"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
