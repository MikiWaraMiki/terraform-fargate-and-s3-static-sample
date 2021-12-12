variable "service_name" {
  type = string
}
variable "environment" {
  type = string
}

variable "vpc_id" {
  description = "The id of vpc"
  type = string
}
variable "elb_sg_ingress_rules" {
  description = "The inbound rules of ELB"
  type = map(map(any))
  default = {}
}
variable "elb_sg_egress_rules" {
  description = "The outbound rules of ELB"
  type = map(map(any))
  default = {}
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
