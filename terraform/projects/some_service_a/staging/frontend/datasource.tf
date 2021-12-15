data "terraform_remote_state" "cdn_origin_access_identity" {
  backend = "s3"

  config = {
    bucket = local.backend_config.bucket
    key = "${local.backend_config.prefix}/cdn_origin_access_identity"
    region = local.backend_config.region
  }
}
