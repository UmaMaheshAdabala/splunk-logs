
output "frontend_repository_url" {
  description = "Frontend ECR repository URL"
  value       = aws_ecr_repository.this["frontend"].repository_url
}

output "backend_repository_url" {
  description = "Backend ECR repository URL"
  value       = aws_ecr_repository.this["backend"].repository_url
}

output "frontend_repository_arn" {
  description = "Frontend ECR repository ARN"
  value       = aws_ecr_repository.this["frontend"].arn
}

output "backend_repository_arn" {
  description = "Backend ECR repository ARN"
  value       = aws_ecr_repository.this["backend"].arn
}
