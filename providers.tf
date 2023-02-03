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
  shared_config_files      = ["/Users/kieranfinn/.aws/config"]
  shared_credentials_files = ["/Users/kieranfinn/.aws/credentials"]
  profile                  = "photosharesite"
}