variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnet_cidr_blocks" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "private_subnet_cidr_blocks" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "db_subnet_cidr_blocks" {
  description = "A list of CIDR blocks for the database subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones for the subnets"
  type        = list(string)
}

variable "ecr_name" {
  description = "The name of the ECR repository"
  type        = string
}

variable "target_group" {
  description = "A map of target group configurations"
  type = map(object({
    name              = string
    port              = number
    protocol          = string
    health_check_path = string
  }))
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_username" {
  description = "The username for the database"
  type        = string
}
variable "db_password" {
  description = "The password for the database"
  type        = string
}
variable "db_allocated_storage" {
  description = "The allocated storage for the database in GB"
  type        = number
}
variable "db_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}
variable "db_engine" {
  description = "The database engine to use (e.g., mysql, postgres)"
  type        = string
}

variable "cluster_name" {
  description = "Cluster Name"
  type        = string
}

