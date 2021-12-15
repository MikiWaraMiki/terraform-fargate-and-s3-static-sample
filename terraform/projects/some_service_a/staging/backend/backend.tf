// NOTE: ecs-serviceとecs-task-definitionはecspressonで管理するため、作成しない
// https://github.com/kayac/ecspresso
module "ecs_backend" {
  source = "../../../../common_modules/fargate_ecs_cluster"

  cluster_name = "${var.environment}-${var.service_name}-backend"
  default_capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
      weight = "1"
      base = "1"
    },
    {
      capacity_provider = "FARGATE_SPOT"
      weight = "1"
      base = "0"
    }
  ]

  environment = var.environment
  service_name = var.service_name
}
