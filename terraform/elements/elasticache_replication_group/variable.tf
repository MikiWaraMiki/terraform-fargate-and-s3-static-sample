variable "auth_token" {
  type        = string
  description = "Auth token for password protecting redis, `transit_encryption_enabled` must be set to `true`. Password must be longer than 16 chars"
  default     = null
}

variable "replication_group_id" {
  type        = string
  description = "Replication group ID with the following constraints: \nA name must contain from 1 to 20 alphanumeric characters or hyphens. \n The first character must be a letter. \n A name cannot end with a hyphen or contain two consecutive hyphens."
  default     = ""
}

variable "description" {
  type = string
  description = "The description of replication group"
  default = ""
}

variable "subnet_group_name" {
  type        = string
  description = "Subnet group name for the ElastiCache instance"
}

variable "parameter_group_name" {
  type = string
  description = "The name of parameter group"
}

variable "security_group_ids" {
  type = list(string)
  default = []
}

variable "maintenance_window" {
  type        = string
  default     = ""
  description = "Maintenance window"
}

variable "cluster_size" {
  type        = number
  default     = 1
  description = "Number of nodes in cluster. *Ignored when `cluster_mode_enabled` == `true`*"
}

variable "port" {
  type        = number
  description = "port of cache"
}

variable "instance_type" {
  type        = string
  description = "Elastic cache instance type"
}

variable "engine_version" {
  type        = string
  description = "Redis engine version"
}

variable "at_rest_encryption_enabled" {
  type        = bool
  default     = false
  description = "Enable encryption at rest"
}

variable "transit_encryption_enabled" {
  type        = bool
  default     = true
  description = <<-EOT
    Set `true` to enable encryption in transit. Forced `true` if `var.auth_token` is set.
    If this is enabled, use the [following guide](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/in-transit-encryption.html#connect-tls) to access redis.
    EOT
}

variable "notification_topic_arn" {
  type        = string
  default     = ""
  description = "Notification topic arn"
}

variable "apply_immediately" {
  type        = bool
  default     = true
  description = "Apply changes immediately"
}

variable "automatic_failover_enabled" {
  type        = bool
  default     = false
  description = "Automatic failover (Not available for T1/T2 instances)"
}

variable "multi_az_enabled" {
  type        = bool
  default     = false
  description = "Multi AZ (Automatic Failover must also be enabled.  If Cluster Mode is enabled, Multi AZ is on by default, and this setting is ignored)"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zone IDs"
  default     = []
}

variable "kms_key_id" {
  type        = string
  description = "The ARN of the key that you wish to use if encrypting at rest. If not supplied, uses service managed encryption. `at_rest_encryption_enabled` must be set to `true`"
  default     = null
}


variable "snapshot_arns" {
  type        = list(string)
  description = "A single-element string list containing an Amazon Resource Name (ARN) of a Redis RDB snapshot file stored in Amazon S3. Example: arn:aws:s3:::my_bucket/snapshot1.rdb"
  default     = []
}


variable "snapshot_name" {
  type        = string
  description = "The name of a snapshot from which to restore data into the new node group. Changing the snapshot_name forces a new resource."
  default     = null
}

variable "snapshot_window" {
  type        = string
  description = "The daily time range (in UTC) during which ElastiCache will begin taking a daily snapshot of your cache cluster."
  default     = "06:30-07:30"
}

variable "snapshot_retention_limit" {
  type        = number
  description = "The number of days for which ElastiCache will retain automatic cache cluster snapshots before deleting them."
  default     = 0
}

variable "final_snapshot_identifier" {
  type        = string
  description = "The name of your final node group (shard) snapshot. ElastiCache creates the snapshot from the primary node in the cluster. If omitted, no final snapshot will be made."
  default     = null
}

variable "cluster_mode_enabled" {
  type        = bool
  description = "Flag to enable/disable creation of a native redis cluster. `automatic_failover_enabled` must be set to `true`. Only 1 `cluster_mode` block is allowed"
  default     = false
}

variable "cluster_mode_replicas_per_node_group" {
  type        = number
  description = "Number of replica nodes in each node group. Valid values are 0 to 5. Changing this number will force a new resource"
  default     = 0
}

variable "cluster_mode_num_node_groups" {
  type        = number
  description = "Number of node groups (shards) for this Redis replication group. Changing this number will trigger an online resizing operation before other settings modifications"
  default     = 0
}

variable "tags" {
  type = map(string)
  default = {}
}
