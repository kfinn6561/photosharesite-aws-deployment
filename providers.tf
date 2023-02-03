# Declaring AWS Provider named 'aws'
provider "aws" {
  shared_config_files      = ["/Users/kieranfinn/.aws/config"]
  shared_credentials_files = ["/Users/kieranfinn/.aws/credentials"]
  profile                  = "photosharesite"
}