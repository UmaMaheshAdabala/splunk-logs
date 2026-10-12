variable "cluster_name" {
  description = "The name of the ECS cluster"
  type        = string
}

variable "container_insights" {
  description = "Enable or disable container insights for the ECS cluster"
  type        = bool
  default     = false
}

variable "task_definition" {
  description = "The task definition for the ECS service"
  type = map(object({
    image          = string
    container_port = number
    cpu            = number
    memory         = number
    log_group_name = string
    target_group   = string
    environment    = map(string)
  }))
}

variable "execution_role_arn" {
  description = "The ARN of the execution role for the ECS task"
  type        = string
}

variable "task_role_arn" {
  description = "The ARN of the task role for the ECS task"
  type        = string
}

variable "aws_region" {
  description = "The AWS region where the ECS cluster is deployed"
  type        = string
}

variable "subnets" {
  description = "The subnets for the ECS service"
  type        = list(string)
}

variable "security_group" {
  description = "The security groups for the ECS service"
  type        = string
}


