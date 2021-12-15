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
