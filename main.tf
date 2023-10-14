terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-2"
  profile = "nl"
  shared_credentials_files = ["/Users/tzumby/.aws/credentials"]
  shared_config_files = ["/Users/tzumby/.aws/config"]
}

resource "aws_vpc" "main" {
  cidr_block = "10.80.0.0/19"

  tags = {
    Name = "elixir-vpc"
  }
}
