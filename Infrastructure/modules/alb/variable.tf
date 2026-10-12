variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "securityGroup_id" {
  description = "The ID of the security group"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet"
  type        = set(string)
}

variable "target_group" {
  description = "target grouop data"
  type = map(object({
    name              = string
    port              = number
    protocol          = string
    health_check_path = string
  }))
}
