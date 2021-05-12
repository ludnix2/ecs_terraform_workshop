terraform {
  required_providers {
    aws = {
      version = ">= 3.0"
    }
  }
}
provider "aws" {
  region = "us-west-1"
}

terraform {
  backend "s3" {
    bucket = "connectto-terraform-backend"
    key    = "state/terraform.tfstate"
    dynamodb_table = "terraform-state-locking"
    region = "us-west-1"
  }
}
