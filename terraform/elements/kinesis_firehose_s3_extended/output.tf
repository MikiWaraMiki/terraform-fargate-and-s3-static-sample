output "arn" {
  description = "The arn of firehose"
  value = aws_kinesis_firehose_delivery_stream.kinesis_firehose_stream.arn
}
