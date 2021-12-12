data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = local.backend_config.bucket
    key = "${local.backend_config.prefix}/network"
    region = local.backend_config.region
  }
}
