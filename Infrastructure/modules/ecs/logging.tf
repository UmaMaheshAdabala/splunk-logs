resource "aws_cloudwatch_log_group" "this" {
  for_each          = var.task_definition
  name              = each.value.log_group_name
  retention_in_days = 30

  tags = {
    Name = "${var.cluster_name}-${each.key}-log-group"
  }
}
