variable "db_name" {
  description = "The name of the database"
  type        = string
}
variable "subnet_ids" {
  description = "A list of subnet IDs for the RDS instance"
  type        = list(string)
}
variable "username" {
  description = "The username for the database"
  type        = string
}
variable "password" {
  description = "The password for the database"
  type        = string
}
variable "allocated_storage" {
  description = "The allocated storage for the database in GB"
  type        = number
}
variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "engine" {
  description = "The database engine to use (e.g., mysql, postgres)"
  type        = string
}
variable "security_group_ids" {
  description = "A list of security group IDs to associate with the RDS instance"
  type        = list(string)
}
