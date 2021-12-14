provider "aws" {
  region = "ap-northeast-1"
}
terraform {
  required_version = ">=1.0.0"

  backend "s3" {
    region = "ap-northeast-1"
  }
}

locals {
  tags = {
    ServiceName = var.service_name
  }
  // タグなしはpushから3日で削除
  untagged_image_rule = [{
    rulePriority = 99
    description  = "Remove untagged images"
    selection = {
      tagStatus   = "untagged"
      countType   = "sinceImagePushed"
      countUnit   = "days"
      countNumber = 3
    }
    action = {
      type = "expire"
    }
  }]
  // tagつきは10イメージ保管
  remove_old_image_rule = [{
    rulePriority = 90
    description  = "Rotate images when reach 10 images stored",
    selection = {
      tagPrefixList = ["codebuild-hash."]
      tagStatus   = "tagged"
      countType   = "imageCountMoreThan"
      countNumber = 10
    }
    action = {
      type = "expire"
    }
  }]

  shared_policy = jsonencode({
    rules = concat(local.untagged_image_rule, local.remove_old_image_rule)
  })
}

module "nginx" {
  source = "../../../../elements/ecr/"

  name = "${var.service_name}-nginx"
  image_tag_mutability = "IMMUTABLE"
  scan_image_on_push = true
  encryption_configuration = {
    encryption_type = "AES256"
    kms_key = null // AWS OWNED KMSによる暗号化
  }

  lifecycle_policy = local.shared_policy

  tags = local.tags
}

module "nestjs" {
  source = "../../../../elements/ecr/"

  name = "${var.service_name}-nestjs"
  image_tag_mutability = "IMMUTABLE"
  scan_image_on_push = true
  encryption_configuration = {
    encryption_type = "AES256"
    kms_key = null // AWS OWNED KMSによる暗号化
  }

  lifecycle_policy = local.shared_policy

  tags = local.tags
}

module "fluentbit" {
  source = "../../../../elements/ecr/"

  name = "${var.service_name}-fluentbit"
  image_tag_mutability = "MUTABLE" // staging prodで切り替えを行うため
  scan_image_on_push = true
  encryption_configuration = {
    encryption_type = "AES256"
    kms_key = null // AWS OWNED KMSによる暗号化
  }

  lifecycle_policy = local.shared_policy

  tags = local.tags
}
