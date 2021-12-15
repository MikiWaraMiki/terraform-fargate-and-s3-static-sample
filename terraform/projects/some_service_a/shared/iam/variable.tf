locals {
  backend_config = yamldecode(file("../config/backend-config.yaml"))
}

variable "service_name" {
  default = "some-service-a"
}
