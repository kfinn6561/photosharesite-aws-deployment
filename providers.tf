terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

# Declaring AWS Provider named 'aws'
provider "aws" {
  region                   = "eu-west-1"
  shared_config_files      = [pathexpand("~/.aws/PSS_config")]
  shared_credentials_files = [pathexpand("~/.aws/PSS_credentials")]
  profile                  = "photosharesite"
}