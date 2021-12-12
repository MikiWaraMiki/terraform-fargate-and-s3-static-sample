output "alb_id" {
  description = "The id of ALB"
  value = module.alb.lb_id
}
output "alb_arn" {
  description = "The arn of ALB"
  value = module.alb.lb_arn
}
output "alb_dns" {
  description = "The dns of ALB"
  value = module.alb.lb_dns_name
}
output "target_group_arns" {
  description = "The created target groups"
  value = module.alb.target_group_arns
}
output "target_group_names" {
  description = "The created target groups"
  value = module.alb.target_group_names
}
