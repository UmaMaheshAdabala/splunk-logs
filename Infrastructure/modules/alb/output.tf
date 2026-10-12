output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "alb_arn" {
  value = aws_lb.this.arn
}

output "alb_target_group_arn" {
  value = { for tg_name, tg in aws_lb_target_group.this : tg_name => tg.arn }
}

