output "bucket_arn" {
  description = "The arn of s3 bucket"
  value = module.s3_bucket_for_logs.s3_bucket_arn
}
output "bucket_id" {
  description = "The id of s3 bucket"
  value = module.s3_bucket_for_logs.s3_bucket_id
}

output "firehose_iam_role_arn" {
  description = "The arn of firehose iam role"
  value = module.firehose_put_iam_role.iam_role_arn
}
output "firehose_iam_role_name" {
  description = "The name of firehose iam role"
  value = module.firehose_put_iam_role.iam_role_name
}
