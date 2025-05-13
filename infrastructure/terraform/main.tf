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

  # Use after bootstrapping bucket to store state in remte backend.

  # backend "s3" {
  #   bucket  = "jhirn-liatrio-exercise-tf-state"
  #   key     = "terraform.tfstate"
  #   region  = "us-west-2"
  #   encrypt = true
  # }
}


provider "aws" {
  region = var.aws_region
}
