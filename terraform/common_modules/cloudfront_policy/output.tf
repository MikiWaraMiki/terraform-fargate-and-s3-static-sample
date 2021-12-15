output "origin_request_policy_id" {
  description = "The id of origin request policy"
  value = module.origin_request_policy.id
}

output "min_ttl_s3_cache_policy_id" {
  description = "The id of min ttl cache policy"
  value = module.min_ttl_s3_origin_policy.id
}

output "assets_cache_policy_id" {
  description = "The id of assets cache policy"
  value = module.assets_cache_policy.id
}
