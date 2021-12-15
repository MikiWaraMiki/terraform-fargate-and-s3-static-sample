// Log Gruop
module "nestjs_log_group" {
  source = "terraform-aws-modules/cloudwatch/aws//modules/log-group"

  name = "ecs/${var.service_name}/${var.environment}/backend"
  retention_in_days = 7

  tags = {
    Environment = var.environment
    ServiceName = var.service_name
  }
}

// Firehose
data "aws_kms_alias" "s3" {
  name = "alias/aws/s3"
}
module "nestjs_log_firehose_log_group" {
  source = "terraform-aws-modules/cloudwatch/aws//modules/log-group"
  name = "firehose/${var.environment}-${var.service_name}-backend-log-stream"
  retention_in_days = 7 // days

  tags = {
    Environment = var.environment
    ServiceName = var.service_name
  }
}
module "nestjs_log_firehose" {
  source = "../../../../elements/kinesis_firehose_s3_extended/"

  kinesis_firehose_stream_name = "${var.environment}-${var.service_name}-backend-log-stream"
  server_side_enryption_option = {
      key_type = "AWS_OWNED_CMK"
  }

  iam_role_arn = data.terraform_remote_state.iam.outputs.firehose_log_delivery_role.iam_role_arn
  bucket_arn = data.terraform_remote_state.logging.outputs.bucket_arn
  prefix = "ecs/backend/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/"
  // NOTE: Kineis Firehose自体のエラーログ
  // アプリのエラーログ保管先ではない
  error_output_prefix = "error/ecs/backend/year=!{timestamp:yyyy}/month=!{timestamp:MM}/day=!{timestamp:dd}/hour=!{timestamp:HH}/!{firehose:error-output-type}"

  buffer_interval = 300 // sec
  buffer_size = 5 // MB

  compression_format = "GZIP"
  kms_key_arn = data.aws_kms_alias.s3.arn

  cloudwatch_log_group_name = module.nestjs_log_firehose_log_group.cloudwatch_log_group_name
  cloudwatch_log_stream_name = "DestinationDelivery"

  tags = {
    Environment = var.environment
    ServiceName = var.service_name
  }
}
