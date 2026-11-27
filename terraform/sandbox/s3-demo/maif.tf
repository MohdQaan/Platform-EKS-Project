terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo" {
  bucket = "dawood-tf-demo-482913" # CHANGE THIS to something unique

  tags = {
    Project   = "platform-eks-gitops"
    ManagedBy = "terraform"
  }
}

output "bucket_name" {
  value = aws_s3_bucket.demo.bucket
}