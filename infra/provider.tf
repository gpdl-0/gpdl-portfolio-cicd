terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # CloudFront requires certificate validation in us-east-1, so we set the region here
  region = var.aws_region
  
  default_tags {
    tags = {
      Project     = "Portfolio"
      ManagedBy   = "Terraform"
      Owner       = "Giovanni"
    }
  }
}
