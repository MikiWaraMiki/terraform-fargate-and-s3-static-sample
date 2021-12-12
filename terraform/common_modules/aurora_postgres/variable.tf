variable "subnet_group_name" {
  description = "The name of subnet group"
  type = string
}
variable "subnet_group_description" {
  description = "The description of subnet group"
  type = string
}
variable "rds_subnet_ids" {
  description = "The id list of rds subnet"
  type = list(string)
}

variable "tags" {
  type = map(string)
  default = {}
}
