terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.21.0"
    }

    docker = {
      source = "kreuzwerker/docker"
      version = "2.17.0"
    }
  }

  backend "s3" {
    # set via -backend-config command line arg
    # bucket = "${var.app_name}-backend-terraform"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

provider "docker" {
  registry_auth {
    address  = local.aws_ecr_url
    username = data.aws_ecr_authorization_token.token.user_name
    password = data.aws_ecr_authorization_token.token.password
  }
}
