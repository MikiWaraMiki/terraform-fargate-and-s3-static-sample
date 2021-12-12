variable "is_create_security_group" {
  description = "When security group creating, this value must be true. default is true"
  type = bool
  default = true
}
variable "name" {
  description = "The name of security group. When is_created_security_group is true, this value must be set."
  type = string
  default = ""
}
variable "description" {
  description = "The description of security group. When is_created_security_group is true, this value must be set."
  type = string
  default = ""
}
variable "vpc_id" {
  description = "The id of vpc"
  type = string
  default = ""
}
variable "tags" {
  description = "The tags of security group"
  type = map(string)
  default = {}
}
variable "security_group_id" {
  description = "The group id of security group. When is_created_security_group is false, this value must be set."
  type = string
  default = ""
}

variable "ingress_rules" {
  description = "The ingress rule of security group."
  type = list(map(any))
  default = []
}
variable "egress_rules" {
  description = "The egress rule of security group."
  type = list(map(any))
  default = []
}
