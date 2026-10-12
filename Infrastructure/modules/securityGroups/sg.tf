resource "aws_security_group" "alb" {
  name        = "${var.vpc_name}-sg"
  description = "Security group for ${var.vpc_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-alb-sg"
  }

}


resource "aws_vpc_security_group_ingress_rule" "alb_rule" {

  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_egress_rule" "alb_egress_rule" {

  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.alb.id
}


resource "aws_security_group" "ecs" {
  name        = "${var.vpc_name}-ecs-sg"
  description = "Security group for ECS  in ${var.vpc_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-ecs-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ecs_frontend_rule" {
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb.id
  security_group_id            = aws_security_group.ecs.id
}

resource "aws_vpc_security_group_ingress_rule" "ecs_backend_rule" {
  from_port                    = 3000
  to_port                      = 3000
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.alb.id
  security_group_id            = aws_security_group.ecs.id
}



resource "aws_vpc_security_group_egress_rule" "ecs_egress_rule" {

  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.ecs.id
}

resource "aws_security_group" "rds" {
  name        = "${var.vpc_name}-rds-sg"
  description = "Security group for RDS in ${var.vpc_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-rds-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "rds_rule" {
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.ecs.id

  security_group_id = aws_security_group.rds.id
}

resource "aws_vpc_security_group_egress_rule" "rds_egress_rule" {

  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.rds.id
}

resource "aws_security_group" "splunk-sg" {
  name        = "${var.vpc_name}-splunk-sg"
  description = "Security group for Splunk in ${var.vpc_name}"
  vpc_id      = var.vpc_id

  tags = {
    Name = "${var.vpc_name}-splunk-sg"
  }
}

resource "aws_vpc_security_group_egress_rule" "splunk_egress_rule" {

  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  security_group_id = aws_security_group.splunk-sg.id
}
