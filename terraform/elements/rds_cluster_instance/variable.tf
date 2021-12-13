variable "identifier" {
  description = "The identifier on `aws_rds_cluster_instance`"
  type = string
}

variable "cluster_identifier" {
  description = "The cluster identifier specified on `aws_rds_cluster`"
  type        = string
}

variable "engine" {
  description = "The name of instance engine"
  type = string
}

variable "engine_version" {
  description = "The version of instance engine"
  type = string
}

variable "instance_class" {
  description = "The class name of instnace"
  type = string
}

variable "publicly_accessible" {
  description = "When assign public ip to instance, this value is true"
  type = bool
  default = false
}

variable "db_subnet_group_name" {
  description = "The name of db subnet group."
  type = string
  // NOTE: Cluster作成時に設定したサブネットグループを適用させる場合はNULL
  default = null
}

variable "db_parameter_group_name" {
  description = "The name of db parameter group"
  type = string
  // NOTE: Cluster作成時に設定したパラメーターグループを適用させる場合はNULL
  default = null
}

variable "apply_immediately" {
  description = "Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false`"
  type        = bool
  default     = false
}

variable "monitoring_role_arn" {
  description = "IAM role used by RDS to send enhanced monitoring metrics to CloudWatch"
  type        = string
  default     = ""
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for instances. Set to `0` to disble. Default is `0`"
  type        = number
  default     = 0
}

variable "promotion_tier" {
  description = "(Optional) Default 0. Failover Priority setting on instance level. The reader who has lower tier has higher priority to get promoted to writer."
  type = number
  default = 0
}

variable "availability_zone" {
  description = "The EC2 Availability Zone that the DB instance is created in. See docs about the details."
  type = string
  default = ""
}

variable "preferred_maintenance_window" {
  description = "The weekly time range during which system maintenance can occur, in (UTC)"
  type        = string
  default     = "thu:19:00-thu:20:00" // default 木曜日04:00-05:00
}
variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Default `true`"
  type        = bool
  default     = false
}
variable "performance_insights_enabled" {
  description = "Specifies whether Performance Insights is enabled or not"
  type        = bool
  default     = false
}

variable "performance_insights_kms_key_id" {
  description = "The ARN for the KMS key to encrypt Performance Insights data"
  type        = string
  default     = null
}

variable "performance_insights_retention_period" {
  description = "Amount of time in days to retain Performance Insights data. Either 7 (7 days) or 731 (2 years)"
  type        = number
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Cluster `tags` to snapshots"
  type        = bool
  default     = true
}

variable "ca_cert_identifier" {
  description = "The identifier of the CA certificate for the DB instance"
  type        = string
  default     = null
}

variable "instance_timeouts" {
  type = map(any)
  default = {
    create = "30m" // 30min
    update = "30m" // 30min
    delete = "30m" // 30min
  }
}

variable "tags" {
  type = map(string)
  default = {}
}
