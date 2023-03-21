terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # tf state is stored in an s3 bucket with versioning enabled

  backend "s3" {
    bucket = "amitytfstate"
    key    = "tfstate/"
    region = "ap-southeast-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}
