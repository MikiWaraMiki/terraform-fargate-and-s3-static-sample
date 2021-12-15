// NOTE: ecs-task-definitionとscheduled taskはecsscheduleで管理するため、作成しない
// https://github.com/Songmu/ecschedule
module "ecs_batch" {
  source = "../../../../common_modules/fargate_ecs_cluster"

  cluster_name = "${var.environment}-${var.service_name}-batch"
  default_capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
      weight = "1"
      base = "0"
    }
  ]

  environment = var.environment
  service_name = var.service_name
}
