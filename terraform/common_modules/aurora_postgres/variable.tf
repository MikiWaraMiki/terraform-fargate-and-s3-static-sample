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

variable "cluster_parameter_group_name" {
  description = "The name of cluster parameter group"
  type = string
}
variable "cluster_parameter_group_description" {
  description = "The description of cluster parameter group"
  type = string
}
variable "cluster_parameter_list" {
  description = "The list of cluster parameter"
  type = list(map(string))
  default = []
}

variable "family" {
  description = "The family of aurora engine"
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}
