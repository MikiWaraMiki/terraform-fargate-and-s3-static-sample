provider "aws" {
  region = "ap-northeast-1"
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
    encrypt = true
  }
}

module "common_security_group" {
  source = "../../../../common_modules/security_group"

  service_name = var.service_name
  environment = var.environment

  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
}
