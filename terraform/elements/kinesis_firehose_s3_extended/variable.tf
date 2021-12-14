variable "kinesis_firehose_stream_name" {
  description = "The name of firehose"
  type = string
}
variable "server_side_enryption_option" {
  description = "When enabled SSE, this value must be set"
  type = map(string)
}
variable "iam_role_arn" {
  description = "The arn of firehose with s3 put record"
  type = string
}
variable "bucket_arn" {
  description = "The arn of destination bucket"
  type = string
}
variable "prefix" {
  description = "The prefix value of log"
  type = string
}
variable "error_output_prefix" {
  description = "The prefix value of log"
  type = string
}

variable "buffer_interval" {
  description = "The value of buffer interval"
  type = number
  default = 300 // sec
}

variable "buffer_size" {
  description = "Buffer incoming data to the specified size, in MBs, before delivering it to the destination."
  type = number
  default = 5 // MB
}

variable "compression_format" {
  description = "The compression format. If no value is specified, the default is UNCOMPRESSED. Other supported values are GZIP, ZIP, Snappy, & HADOOP_SNAPPY."
  type = string
  default = "UNCOMPRESSED"
}

variable "kms_key_arn" {
  description = "(Optional) Specifies the KMS key ARN the stream will use to encrypt data. If not set, no encryption will be used"
  type = string
  default = null
}

variable "cloudwatch_log_group_name" {
  description = "The CloudWatch Logging Options for the delivery stream. More details are given below"
  type = string
  default = null
}
variable "cloudwatch_log_stream_name" {
  description = "The CloudWatch Logging Options for the delivery stream. More details are given below"
  type = string
  default = null
}

variable "tags" {
  type = map(string)
  default = {}
}
