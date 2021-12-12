provider "aws" {
  region = "ap-northeast-1"
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}
module "network" {
  source = "../../../../common_modules/network"

  vpc_name = "staging-some-service-a"
  vpc_cidr = "172.19.0.0/16"

  elb_subnet_attributes = {
    1: {
      name = "${var.environment}-${var.service_name}-elb-subnet-1a"
      cidr_block = "172.19.0.0/24"
      availability_zone = "ap-northeast-1a"
    },
    2: {
      name = "${var.environment}-${var.service_name}-elb-subnet-1c"
      cidr_block = "172.19.1.0/24"
      availability_zone = "ap-northeast-1c"
    }
  }

  web_subnet_attributes = {
    1: {
      name = "${var.environment}-${var.service_name}-web-subnet-1a"
      cidr_block = "172.19.2.0/24"
      availability_zone = "ap-northeast-1a"
    },
    2: {
      name = "${var.environment}-${var.service_name}-web-subnet-1c"
      cidr_block = "172.19.3.0/24"
      availability_zone = "ap-northeast-1c"
    }
  }

  rds_subnet_attributes = {
    1: {
      name = "${var.environment}-${var.service_name}-rds-subnet-1a"
      cidr_block = "172.19.10.0/24"
      availability_zone = "ap-northeast-1a"
    },
    2: {
      name = "${var.environment}-${var.service_name}-rds-subnet-1c"
      cidr_block = "172.19.11.0/24"
      availability_zone = "ap-northeast-1c"
    }
  }

  elasticache_subnet_attributes = {
    1: {
      name = "${var.environment}-${var.service_name}-elasticache-subnet-1a"
      cidr_block = "172.19.16.0/24"
      availability_zone = "ap-northeast-1a"
    },
    2: {
      name = "${var.environment}-${var.service_name}-elasticache-subnet-1c"
      cidr_block = "172.19.17.0/24"
      availability_zone = "ap-northeast-1c"
    }
  }

  management_subnet_attributes = {
    1: {
      name = "${var.environment}-${var.service_name}-management-subnet-1a"
      cidr_block = "172.19.250.0/24"
      availability_zone = "ap-northeast-1a"
    },
    2: {
      name = "${var.environment}-${var.service_name}-management-subnet-1c"
      cidr_block = "172.19.251.0/24"
      availability_zone = "ap-northeast-1a"
    }
  }


  environment = var.environment
  service_name = var.service_name

  tags = {
    Environment = var.environment
  }
}
