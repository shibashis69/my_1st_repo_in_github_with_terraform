terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.2"
    }
  }
}

provider "aws" {
  region = "eu-central-1"
  shared_credentials_file = "/home/shibashis/my_project1/.aws/awscred"
  profile = "awskey"
}
