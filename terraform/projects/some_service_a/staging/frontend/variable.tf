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
