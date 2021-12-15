variable "name" {
  description = "The name of ALB"
  type = string
}
variable "vpc_id" {
  description = "The id of VPC"
  type = string
}
variable "elb_subnet_ids" {
  description = "The list of elb subnet id"
  type = list(string)
}
variable "elb_security_group_ids" {
  description = "The list of elb security group id"
  type = list(string)
}
variable "target_group_attributes" {
  description = "The attributes of target group"
  type = list(any)
}
variable "https_listeners" {
  description = "The list of https listener"
  type = list(any)
}
variable "https_listener_rules" {
  description = "The list of https listener rule"
  type = list(any)
}
variable "is_enable_logging" {
  description = "When logging is disable, this value must be false"
  type = bool
  default = false
}
variable "logging_setting" {
  description = "The logging settings"
  type = map(string)
  default = {}
}
variable "tags" {
  type = map(string)
  default = {}
}
