output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}
output "alb_sg_id" {
  description = "AWS ALB SecurityGroup ID"
  value       = module.security_groups.alb_sg_id
}

output "ecs_sg_id" {
  description = "AWS ECS SecurityGroup ID"
  value       = module.security_groups.ecs_sg_id
}

output "splunk_sg_id" {
  description = "AWS Splunk SecurityGroup ID"
  value       = module.security_groups.splunk_sg_id
}

output "rds_sg_id" {
  description = "AWS RDS SecurityGroup ID"
  value       = module.security_groups.rds_sg_id
}

output "frontend_ecr_repository_url" {
  description = "Frontend ECR repository URL"
  value       = module.ecr.frontend_repository_url
}

output "backend_ecr_repository_url" {
  description = "Backend ECR repository URL"
  value       = module.ecr.backend_repository_url
}

output "ecs_task_execution_role_arn" {
  description = "ECS task execution role ARN"
  value       = module.iam.ecs_task_execution_role_arn
}

output "ecs_task_role_arn" {
  description = "ECS task role ARN"
  value       = module.iam.ecs_task_role_arn
}

output "lambda_execution_role_arn" {
  description = "Lambda execution role ARN"
  value       = module.iam.lambda_execution_role_arn
}

output "ec2_role_arn" {
  description = "EC2 role ARN"
  value       = module.iam.ec2_role_arn
}

output "ec2_instance_profile_name" {
  description = "EC2 instance profile name"
  value       = module.iam.ec2_instance_profile_name
}

output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = module.alb.alb_dns_name
}

output "target_group_arns" {
  description = "A map of target group ARNs"
  value       = module.alb.alb_target_group_arn
}

output "db_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = module.rds.db_endpoint
}

output "db_instance_port" {
  description = "The port of the RDS instance"
  value       = module.rds.db_port
}

output "db_instance_id" {
  description = "RDS instance identifier"
  value       = module.rds.db_instance_id
}
