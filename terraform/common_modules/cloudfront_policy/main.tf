// CloudFront Origin Request Policy
// マネージドルールと一緒だが変更ができるように環境ごとに作成しておく
module "origin_request_policy" {
  source = "../../elements/cloudfront_origin_request_policy/"

  name = "${var.environment}-${var.service_name}-origin-policy"
  comment = "For ${var.environment} ${var.service_name}"

  cookie_behavior = "all"
  header_behavior = "allViewer"
  query_string_behavior = "all"
}

// S3 Origin用(asset以外) cache policy
module "min_ttl_s3_origin_policy" {
  source = "../../elements/cloudfront_cache_policy/"
  name = "${var.environment}-${var.service_name}-min-ttl-policy"
  comment = "For ${var.environment} ${var.service_name}"

  default_ttl = 1 // 1sec
  max_ttl = 1 // 1sec
  min_ttl = 1 // 1sec

  cookie_behavior = "none"
  header_behavior = "none"
  query_string_behavior = "none"
}

// S3 Origin用(assets) cache policy
// TODO: 運用状況に応じてマネージドのCache Optimezed Policyに変更する
module "assets_cache_policy" {
  source = "../../elements/cloudfront_cache_policy/"
  name = "${var.environment}-${var.service_name}-assets-policy"
  comment = "For ${var.environment} ${var.service_name}"

  default_ttl = 10 // 10sec
  max_ttl = 10 // 10sec
  min_ttl = 10 // 10sec

  cookie_behavior = "none"
  header_behavior = "none"
  query_string_behavior = "none"
}
