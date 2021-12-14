output "arn" {
  description = "The arn of s3 bucket"
  value = module.s3_bucket_for_logs.s3_bucket_arn
}
output "bucket_id" {
  description = "The id of s3 bucket"
  value = module.s3_bucket_for_logs.s3_bucket_id
}
