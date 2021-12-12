variable "name" {
  description = "The name of subnet group"
  type = string
}
variable "description" {
  description = "The description of subnet group"
  type = string
}
variable "subnet_ids" {
  description = "The id list of rds subnet"
  type = list(string)
}

variable "tags" {
  type = map(string)
  default = {}
}
