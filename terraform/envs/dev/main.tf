terraform {
  required_version = ">= 1.10"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket       = "tfstate-242944508335-us-east-1"
    key          = "envs/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"

  # Every resource gets these tags automatically
  default_tags {
    tags = {
      Project     = "platform-eks-gitops"
      Environment = "dev"
      ManagedBy   = "terraform"
    }
  }
}
