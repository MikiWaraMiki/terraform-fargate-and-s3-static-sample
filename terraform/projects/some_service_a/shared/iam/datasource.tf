data "terraform_remote_state" "logging" {
  backend = "s3"

  config = {
    bucket = local.backend_config.bucket
    key = "${local.backend_config.prefix}/logging"
    region = local.backend_config.region
  }
}
