variable "service_name" {
  type = string
}
variable "environment" {
  type = string
}

variable "bucket_name" {
  descritpion = "バケット名"
  type = string
}

variable "cf_origin_access_identity_iam_arn" {
  description = "S3上のバケットにアクセスを許可するCloudfront OAIのIAM ARN"
  type = string
}

variable "tags" {
  descrition = "リソースに付与するタグ"
  type = map(string)
  default = {}
}
