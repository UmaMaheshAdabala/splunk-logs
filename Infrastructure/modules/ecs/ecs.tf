resource "aws_ecs_service" "this" {
  for_each = var.task_definition

  name                               = "${var.cluster_name}-${each.key}-service"
  cluster                            = aws_ecs_cluster.this.id
  task_definition                    = aws_ecs_task_definition.this[each.key].arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  network_configuration {
    subnets          = var.subnets
    security_groups  = [var.security_group]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = each.value.target_group
    container_name   = each.key
    container_port   = each.value.container_port
  }
  enable_execute_command = true

  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }

  tags = {
    Name = "${var.cluster_name}-${each.key}-service"
  }


}
