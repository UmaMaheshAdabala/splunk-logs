output "cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.this.id
}

output "cluster_name" {
  description = "Cluster name"
  value       = aws_ecs_cluster.this.name
}

output "service_names" {
  description = "ECS service names keyed by service name"
  value = {
    for name, service in aws_ecs_service.this :
    name => service.name
  }
}

output "service_arns" {
  description = "ECS service ARNs keyed by service name"
  value = {
    for name, service in aws_ecs_service.this :
    name => service.arn
  }
}

output "task_definition_arns" {
  description = "Task definition ARNs keyed by service name"
  value = {
    for name, task in aws_ecs_task_definition.this :
    name => task.arn
  }
}
