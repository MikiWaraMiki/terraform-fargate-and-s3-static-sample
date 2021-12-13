variable "service_name" {
  type = string
}
variable "environment" {
  type = string
}

// subnet group
variable "subnet_group_name" {
  description = "The name of subnet group"
  type = string
}

variable "subnet_ids" {
  description = "The ids of redis subnet group"
  type = list(string)
}
// parameter group
variable "parameter_group_name" {
  description = "The name of parameter gruop"
  type = string
}
variable "parameter" {
  description = "The parameter of redis"
  type = list(any)
  default = []
}
variable "family" {
  description = "The family of redis"
  type = string
  default = "redis6.x"
}

variable "tags" {
  type = map(string)
  default = {}
}
