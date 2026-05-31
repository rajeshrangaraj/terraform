terraform {
  required_version = ">= 1.8.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.env
      ManagedBy   = "terraform"
    }
  }
}

module "app_server" {
  source = "../../modules/ec2"

  env           = var.env
  name          = "app-server"
  ami_id        = var.ami_id
  instance_type = var.instance_type

  tags = {
    Team    = "platform"
    Service = "app-server"
  }
}