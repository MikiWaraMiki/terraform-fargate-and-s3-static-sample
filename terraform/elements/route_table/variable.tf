variable "vpc_id" {
  description = "The id of vpc"
  type = string
}

variable "name" {
  description = "The name of route table"
  type = string
}

variable "is_public_route_table" {
  type = bool
  default = false
}
variable "is_private_route_table" {
  type = bool
  default = false
}
variable "is_create_default_route" {
  type = bool
  default = false
}

variable "igw_id" {
  description = "The public subnet is required. IGW ID"
  type = string
  default = ""
}
variable "nat_gateway_id" {
  description = "The private subnet nat gaway id."
  type = string
  default = ""
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
