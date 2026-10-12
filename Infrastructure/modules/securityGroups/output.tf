output "alb_sg_id" {
  description = "AWS ALB SecurityGroup ID"
  value       = aws_security_group.alb.id
}

output "ecs_sg_id" {
  description = "AWS ECS SecurityGroup ID"
  value       = aws_security_group.ecs.id
}

output "splunk_sg_id" {
  description = "AWS Splunk SecurityGroup ID"
  value       = aws_security_group.splunk-sg.id
}

output "rds_sg_id" {
  description = "AWS RDS SecurityGroup ID"
  value       = aws_security_group.rds.id
}
