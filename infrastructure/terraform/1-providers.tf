terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }


  # TODO: Implement remote state and dynamo for concurrent use.
  # backend "s3" {
  #   bucket  = "jhirn-liatrio-exercise-tf-state"
  #   key     = "terraform.tfstate"
  #   region  = "us-west-2"
  #   encrypt = true
  #   dynamodb_table = "tf-state-lock"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = var.tags
  }

  max_retries = 3
}
