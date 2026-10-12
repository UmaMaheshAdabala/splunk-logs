variable "name" {
  description = "Name of the ECR repository"
  type        = string
}


variable "ecr_repo" {
  description = "ECR Details"
  type        = set(string)

  default = [
    "frontend",
    "backend"
  ]
}
