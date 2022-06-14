terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    bucket         = "asediuk-tfstate-bucket"
    dynamodb_table = "asediuk-tfstate-lock"
    key            = "aws_tf_state/aws_linux.tfstate"
    region         = "eu-west-2"
    encrypt        = "true"
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}