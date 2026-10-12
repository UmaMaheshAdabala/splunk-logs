resource "aws_lb" "this" {
  name               = "${var.vpc_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.securityGroup_id]
  subnets            = var.subnet_id

  enable_deletion_protection = false

  tags = {
    Name = "${var.vpc_name}-alb"
  }
}

resource "aws_lb_target_group" "this" {
  for_each    = var.target_group
  name        = each.value.name
  port        = each.value.port
  protocol    = each.value.protocol
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path                = each.value.health_check_path
    protocol            = each.value.protocol
    interval            = 30
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = each.value.name
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn

  port     = 80
  protocol = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn = aws_lb_target_group.this["frontend"].arn
      }
    }
  }
}

resource "aws_lb_listener_rule" "this" {
  listener_arn = aws_lb_listener.this.arn
  priority     = 100
  action {
    type = "forward"
    forward {
      target_group {
        arn = aws_lb_target_group.this["backend"].arn
      }
    }

  }
  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
}

