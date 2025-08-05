terraform {
  backend "s3" {
    bucket = "terraform-remote-states-resizes"
    key    = "aws/medusa"
    region = "eu-west-1"
    acl    = "bucket-owner-full-control"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.6"
}

provider "aws" {
  region = "eu-west-1"
  assume_role {
    role_arn = "arn:aws:iam::917563509651:role/terraform"
  }
}