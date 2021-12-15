output "origin_request_policy_id" {
  description = "The value of origin request policy"
  value = module.cloudfront_policy.origin_request_policy_id
}

output "min_ttl_s3_cache_policy_id" {
  description = "The id of min ttl cache policy"
  value = module.cloudfront_policy.min_ttl_s3_cache_policy_id
}

output "assets_cache_policy_id" {
  description = "The id of assets cache policy"
  value = module.cloudfront_policy.min_ttl_s3_cache_policy_id
}

output "cloudfront_distribution_id" {
  description = "The identifier for the distribution."
  value       = module.distribution.cloudfront_distribution_id
}

output "cloudfront_distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution."
  value       = module.distribution.cloudfront_distribution_arn
}

output "cloudfront_distribution_caller_reference" {
  description = "Internal value used by CloudFront to allow future updates to the distribution configuration."
  value       = module.distribution.cloudfront_distribution_caller_reference
}
