variable "service_name" {
  type = string
}
variable "environment" {
  type = string
}

variable "vpc_name" {
  type = string
  description = "The name of VPC"
}

variable "vpc_cidr" {
  type = string
  description = "The CIDR block of VPC"
}

variable "elb_subnet_attributes" {
  type = map(map(string))
  description = "The attributes of ELB Subnet"
}

variable "web_subnet_attributes" {
  type = map(map(string))
  description = "The attributes of ECS web Subnet"
}

variable "rds_subnet_attributes" {
  type = map(map(string))
  description = "The attributes of RDS Subnet"
}

variable "elasticache_subnet_attributes" {
  type = map(map(string))
  description = "The attributes of Elasticache Subnet"
}

variable "management_subnet_attributes" {
  type = map(map(string))
  description = "The attributes of management Subnet"
}

variable "ingress_public_nacl_rules" {
  type = map(map(string))
  description = "The nacl rule of ingress"
  default = {}
}
variable "egress_public_nacl_rules" {
  type = map(map(string))
  description = "The nacl rule of ingress"
  default = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
