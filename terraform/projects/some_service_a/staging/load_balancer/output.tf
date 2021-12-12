output "alb_id" {
  description = "The id of ALB"
  value = module.public_alb.alb_id
}
output "alb_arn" {
  description = "The arn of ALB"
  value = module.public_alb.alb_arn
}
output "alb_dns" {
  description = "The dns of ALB"
  value = module.public_alb.alb_dns
}
output "target_group_arns" {
  description = "The created target groups"
  value = module.public_alb.target_group_arns
}
output "target_group_names" {
  description = "The created target groups"
  value = module.public_alb.target_group_names
}
