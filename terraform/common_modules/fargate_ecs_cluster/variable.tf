variable "service_name" {
  type = string
}
variable "environment" {
  type = string
}

variable "cluster_name" {
  description = "The name of ecs cluster"
  type = string
}

variable "default_capacity_provider_strategy" {
  description = "The default capacity provider settings"
  type = list(map(any))
  default = []
}



variable "tags" {
  type = map(string)
  default = {}
}
