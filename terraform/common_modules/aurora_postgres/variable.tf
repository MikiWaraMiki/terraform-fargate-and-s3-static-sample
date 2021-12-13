// subnet group
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

// cluster parameter group
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

// parameter group
variable "db_parameter_group_name" {
  description = "The name of cluster parameter group"
  type = string
}
variable "db_parameter_group_description" {
  description = "The description of cluster parameter group"
  type = string
}
variable "db_parameter_list" {
  description = "The list of cluster parameter"
  type = list(map(string))
  default = []
}

variable "family" {
  description = "The family of aurora engine"
  type = string
}


// aurora cluster
variable "aurora_cluster_name" {
  description = "The name of aurora cluster"
  type = string
}

variable "engine_version" {
  description = "The version of aurora postgres"
  type = string
}

variable "backup_retention_period" {
  description = "The count of backup snapshot. default is 7"
  type = number
  default = 7
}

variable "preferred_backup_window" {
  description = "The weekly time range during which system maintenance can occur, in (UTC)"
  type = string
  default = "18:00-19:00" // default is 03:00-04:00 (JST)
}
variable "preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur, in (UTC)"
  type = string
  default = "wed:20:00-wed:21:00" // default is wed 05:00-06:00(JST)
}
variable "rds_security_group_ids" {
  description = "The ids of security group for rds"
  type = list(string)
}
variable "enabled_cloudwatch_logs_exports" {
  description = "The value of log setting"
  type = list(string)
  default = ["postgresql"]
}

variable "tags" {
  type = map(string)
  default = {}
}
