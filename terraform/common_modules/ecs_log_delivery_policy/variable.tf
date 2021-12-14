variable "service_name" {
  type = string
}
variable "environment" {
  type = string
}

variable "policy_name" {
  description = "The name of policy"
  type = string
}

variable "firehose_arns" {
  description = "The arn list of firehose"
  type = list(string)
  default = []
}

variable "tags" {
  type = map(string)
  default = {}
}
