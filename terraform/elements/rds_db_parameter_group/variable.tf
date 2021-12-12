variable "name" {
  description = "The name of parameter group"
  type = string
}
variable "family" {
  description = "The family of parameter group"
  type = string
}
variable "description" {
  description = "The description of parameter group"
  type = string
}

variable "parameter_list" {
  description = "The parameter list"
  type = list(map(string))
  default = []
}

variable "tags" {
  type = map(string)
  default = {}
}
