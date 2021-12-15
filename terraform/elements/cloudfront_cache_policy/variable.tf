variable "name" {
  description = "The name of request policy"
  type = string
}
variable "comment" {
  description = "The comment of request policy"
  type = string
}
variable "default_ttl" {
  description = "Default ttl"
  type = number
}
variable "max_ttl" {
  description = "Max TTL"
  type = number
}
variable "min_ttl" {
  description = "Min TTL"
  type = number
}
variable "cookie_behavior" {
  description = <<EOF
   (Required) Determines whether any cookies in viewer requests are included in the origin request key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist all. cookies
  EOF
  type = string
}

variable "origin_request_cookies" {
  description = "List of item names (cookies, headers, or query strings)."
  type = list(string)
  default = []
}

variable "header_behavior" {
  description = <<EOF
    (Required) Determines whether any HTTP headers are included in the origin request key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, allViewer, allViewerAndWhitelistCloudFront. headers
  EOF
  type = string
}

variable "origin_request_headers" {
  description = "List of item names (cookies, headers, or query strings)."
  type = list(string)
  default = []
}

variable "query_string_behavior" {
  description = <<EOF
  (Required) Determines whether any URL query strings in viewer requests are included in the origin request key and automatically included in requests that CloudFront sends to the origin. Valid values are none, whitelist, all. query_strings - (Optional) Object that contains a list of query string names. See Items for more information.
  EOF
  type = string
}

variable "origin_query_strings" {
  description = "List of item names (cookies, headers, or query strings)."
  type = list(string)
  default = []
}
