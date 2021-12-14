variable "service_name" {
  type = string
}
variable "environment" {
  type = string
}

// subnet group
variable "subnet_group_name" {
  description = "The name of subnet group"
  type = string
}

variable "subnet_ids" {
  description = "The ids of redis subnet group"
  type = list(string)
}
// parameter group
variable "parameter_group_name" {
  description = "The name of parameter gruop"
  type = string
}
variable "parameter" {
  description = "The parameter of redis"
  type = list(any)
  default = []
}
variable "family" {
  description = "The family of redis"
  type = string
  default = "redis6.x"
}


variable "security_group_ids" {
  description = "The id list of security group for redis"
  type = list(string)
  default = []
}

// replication group
variable "replication_group_id" {
  description = "The id of replication group"
  type = string
  default = ""
}
variable "redis_maintenance_window" {
  description = "The maintenance window of redis"
  type = string
  default = "mon:20:00-mon:21:00" // JST 5:00 - 6:00
}
variable "cluster_size" {
  description = "The size of cluster"
  type = number
  default = 0
}
variable "instance_type" {
  description = "The type of instance"
  type = string
}
variable "engine_version" {
  description = "The version of redis"
  type = string
}

variable "multi_az_enabled" {
  type = bool
  default = true
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zone IDs"
  default     = []
}


variable "tags" {
  type = map(string)
  default = {}
}
