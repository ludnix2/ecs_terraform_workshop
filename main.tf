terraform {
  required_providers {
    aws = {
      version = ">= 3.0"
    }
  }
}
provider "aws" {
  region = "eu-central-1"
}

/*
terraform {
  backend "s3" {
    bucket = "ecsworkshopbucket"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}
*/
