resource "aws_kinesis_firehose_delivery_stream" "kinesis_firehose_stream" {
  name        = var.kinesis_firehose_stream_name
  destination = "extended_s3"

  server_side_encryption {
    enabled = var.server_side_enryption_option != {}
    key_type = lookup(var.server_side_enryption_option, "key_type", null)
    key_arn = lookup(var.server_side_enryption_option, "key_arn", null)
  }

  extended_s3_configuration {
    role_arn       = var.iam_role_arn
    bucket_arn     = var.bucket_arn

    prefix         = var.prefix
    error_output_prefix = var.error_output_prefix

    buffer_interval = var.buffer_interval
    buffer_size    = var.buffer_size
    compression_format = var.compression_format

    kms_key_arn = var.kms_key_arn

    cloudwatch_logging_options {
      enabled         = var.cloudwatch_log_group_name != null
      log_group_name  = var.cloudwatch_log_group_name
      log_stream_name = var.cloudwatch_log_stream_name
    }
  }

  tags = var.tags
}
