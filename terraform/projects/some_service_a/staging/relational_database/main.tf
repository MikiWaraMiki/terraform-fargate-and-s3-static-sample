provider "aws" {
  region = "ap-northeast-1"
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}

module "aurora_postgres" {
  source = "../../../../common_modules/aurora_postgres"
  subnet_group_name = "${var.environment}-${var.service_name}-subnet"
  subnet_group_description = "For ${var.environment}."
  rds_subnet_ids = data.terraform_remote_state.network.outputs.rds_subnet_ids

  tags = {
    Environment = var.environment
  }
}
