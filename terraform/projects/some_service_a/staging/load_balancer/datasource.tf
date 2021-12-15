data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = local.backend_config.bucket
    key = "${local.backend_config.prefix}/network"
    region = local.backend_config.region
  }
}

data "terraform_remote_state" "security_group" {
  backend = "s3"

  config = {
    bucket = local.backend_config.bucket
    key = "${local.backend_config.prefix}/security_group"
    region = local.backend_config.region
  }
}

data "terraform_remote_state" "logging" {
  backend = "s3"

  config = {
    bucket = local.backend_config.bucket
    key = "${local.backend_config.prefix}/logging"
    region = local.backend_config.region
  }

}
