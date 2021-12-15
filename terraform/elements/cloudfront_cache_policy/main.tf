resource "aws_cloudfront_cache_policy" "this" {
  name = var.name
  comment = var.comment

  default_ttl = var.default_ttl
  max_ttl = var.max_ttl
  min_ttl = var.min_ttl

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = var.cookie_behavior
      dynamic "cookies" {
        for_each = var.cookie_behavior == "whitelist" ? {1: "dummy"} : {}

        content {
          items = var.origin_request_cookies
        }
      }
    }

    headers_config {
      header_behavior = var.header_behavior

      dynamic "headers" {
        for_each = var.header_behavior == "whitelist" ? {1: "dummy"} : {}

        content {
          items = var.origin_request_headers
        }
      }
    }

    query_strings_config {
      query_string_behavior = var.query_string_behavior

      dynamic "query_strings" {
        for_each = var.query_string_behavior == "whitelist" ? {1: "dummy"} : {}

        content {
          items = var.origin_query_strings
        }
      }
    }
  }
}
