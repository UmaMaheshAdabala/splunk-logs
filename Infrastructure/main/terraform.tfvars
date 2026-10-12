aws_region                 = "us-east-1"
vpc_cidr_block             = "10.0.0.0/16"
vpc_name                   = "splunk-vpc"
public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr_blocks = ["10.0.3.0/24", "10.0.4.0/24"]
db_subnet_cidr_blocks      = ["10.0.5.0/24", "10.0.6.0/24"]
availability_zones         = ["us-east-1a", "us-east-1b"]
ecr_name                   = "splunk-ecr"

target_group = {
  frontend = {
    name              = "frontend"
    port              = 80
    protocol          = "HTTP"
    health_check_path = "/health"
  }
  backend = {
    name              = "backend"
    port              = 3000
    protocol          = "HTTP"
    health_check_path = "/api/health"
  }
}

db_name              = "splunkdb"
db_username          = "splunkuser"
db_password          = "splunkpassword"
db_allocated_storage = 20
db_instance_class    = "db.t3.micro"
db_engine            = "mysql"
cluster_name         = "ecs-splunk-cluster"
