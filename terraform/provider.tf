terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["/home/aurelien/.aws/config"]
  shared_credentials_files = ["/home/aurelien/.aws/credentials"]
  profile                  = "aburie"
}
