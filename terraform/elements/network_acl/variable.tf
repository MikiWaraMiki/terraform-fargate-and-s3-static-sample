variable "name" {
  description = "The name of ACL"
  type = string
}
variable "vpc_id" {
  description = "The id of VPC"
  type = string
}
variable "subnet_ids" {
  description = "The ids of attachment subnets"
  type = list(string)
  default = []
}

variable "ingnress_rule" {
  description = "The rule map of inbound"
  type = map(map(string))
  default = {}
}
variable "egress_rule" {
  description = "The rule map of outbound"
  type = map(map(string))
  default = []
}

variable "tags" {
  description = "The tags of resource"
  type = map(string)
  default = []
}
