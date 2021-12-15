variable "service_name" {
  type = string
}
variable "environment" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "cf_origin_access_identity_iam_arn" {
  description = "Cloudfront Origin access identity id"
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}
