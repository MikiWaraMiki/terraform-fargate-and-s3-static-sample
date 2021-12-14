variable "service_name" {
  type = string
}
variable "environment" {
  type = string
}
// IAM TaskExceution Policy

// SSM Parameter storeへのアクセス許可を与える場合のフラグ
variable "is_create_parameter_store_access_policy" {
  type = bool
  default = false
}
variable "ssm_parameter_store_resources" {
  type = list(string)
  default = []
}
variable "kms_parameter_store_resources" {
  type = list(string)
  default = []
}
variable "parameter_store_access_policy_name" {
  type = string
  default = ""
}
//


variable "ecs_task_execution_role_name" {
  type = string
  default = ""
}

variable "tags" {
  type = map(string)
  default = {}
}
