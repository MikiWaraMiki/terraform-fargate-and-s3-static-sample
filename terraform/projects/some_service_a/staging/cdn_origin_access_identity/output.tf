output "id" {
  description = "The identifier for the distribution"
  value = aws_cloudfront_origin_access_identity.this.id
}

output "iam_arn" {
  description = "A pre-generated ARN for use in S3 bucket policies (see below). "
  value = aws_cloudfront_origin_access_identity.this.iam_arn
}

output "cloudfront_access_identity_path" {
  description = " A shortcut to the full path for the origin access identity to use in CloudFront"
  value = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
}
