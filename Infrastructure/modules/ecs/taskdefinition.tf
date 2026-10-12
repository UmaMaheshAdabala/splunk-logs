resource "aws_ecs_task_definition" "this" {
  for_each                 = var.task_definition
  family                   = "${var.cluster_name}-${each.key}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = each.value.cpu
  memory                   = each.value.memory
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  container_definitions = jsonencode([
    {
      name      = each.key
      image     = each.value.image
      cpu       = each.value.cpu
      memory    = each.value.memory
      essential = true
      portMappings = [
        {
          containerPort = each.value.container_port
          hostPort      = each.value.container_port
          protocol      = "tcp"
        }
      ]
      environment = [
        for name, value in each.value.environment : {
          name  = name
          value = value
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = each.value.log_group_name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = each.key
        }
      }
      linuxParameters = {
        initProcessEnabled = true
      }
    }
  ])

  tags = {
    Name = "${var.cluster_name}-${each.key}-task-definition"
  }
}
