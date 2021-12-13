variable "role_name" {
  description = "The name of role"
  type = string
}
variable "role_description" {
  description = "The description of role"
  type = string
}
variable "role_path" {
  description = "The path of role"
  type = string
  default = "/"
}
variable "tags" {
  type = map(string)
  default = {}
}
