variable "name" {
  description = "The name of parameter group"
  type = string
}

variable "description" {
  description = "The description of parameter gruop"
  type = string
}

variable "family" {
  description = "The family of elasticache"
  type = string
}

variable "cluster_mode_enabled" {
  description = "The"
  type = bool
  default = false
}

variable "parameter" {
  description = "The list of parameter"
  type = list(any)
  default = []
}

variable "tags" {
  type = map(string)
  default = {}
}
