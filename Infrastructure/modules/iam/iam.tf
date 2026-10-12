
# ECS task execution role
data "aws_iam_policy_document" "ecs_task_execution_role_policy" {

  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]

  }

}

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.vpc_name}-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role_policy.json
  tags = {
    Name = "${var.vpc_name}-ecs-task-execution-role"
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# ECS task role


resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.vpc_name}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role_policy.json
  tags = {
    Name = "${var.vpc_name}-ecs-task-role"
  }
}

# lambda execution role

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}
resource "aws_iam_role" "lambda_execution_role" {
  name               = "${var.vpc_name}-lambda-execution-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
  tags = {
    Name = "${var.vpc_name}-lambda-execution-role"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_execution_role_policy_attachment" {
  role       = aws_iam_role.lambda_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Splunk Role

data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_role" "ec2_role" {
    name              = "${var.vpc_name}-ec2-role"
    assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
    tags = {
      Name = "${var.vpc_name}-ec2-role"
    }
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.vpc_name}-ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}


