locals {
  backend_config = yamldecode(file("../config/backend-config.yaml"))
}

variable "environment" {
  type = string
  default = "staging"
}

variable "service_name" {
  default = "some-service-a"
}

// ELBに設定するドメイン名
variable "elb_domain_name_prefix" {
  default = "alb"
}
