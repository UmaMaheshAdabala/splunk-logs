module "vpc" {
  source = "../modules/vpc"

  vpc_cidr_block             = var.vpc_cidr_block
  vpc_name                   = var.vpc_name
  public_subnet_cidr_blocks  = var.public_subnet_cidr_blocks
  private_subnet_cidr_blocks = var.private_subnet_cidr_blocks
  db_subnet_cidr_blocks      = var.db_subnet_cidr_blocks
  availability_zones         = var.availability_zones
}

module "security_groups" {
  source = "../modules/securityGroups"

  vpc_name = var.vpc_name
  vpc_id   = module.vpc.vpc_id

}

module "ecr" {
  source = "../modules/ecr"

  name = var.ecr_name

}

module "iam" {
  source = "../modules/iam"

  vpc_name = var.vpc_name
}

module "alb" {
  source = "../modules/alb"

  vpc_name         = var.vpc_name
  vpc_id           = module.vpc.vpc_id
  securityGroup_id = module.security_groups.alb_sg_id
  subnet_id        = module.vpc.public_subnet_ids
  target_group     = var.target_group
}

module "rds" {
  source = "../modules/rds"

  db_name            = var.db_name
  subnet_ids         = module.vpc.db_subnet_ids
  username           = var.db_username
  password           = var.db_password
  allocated_storage  = var.db_allocated_storage
  instance_class     = var.db_instance_class
  engine             = var.db_engine
  security_group_ids = [module.security_groups.rds_sg_id]
}

module "ecs" {
  source = "../modules/ecs"

  cluster_name       = var.cluster_name
  container_insights = true
  execution_role_arn = module.iam.ecs_task_execution_role_arn
  task_role_arn      = module.iam.ecs_task_role_arn
  aws_region         = var.aws_region
  subnets            = module.vpc.private_subnet_ids
  security_group     = module.security_groups.ecs_sg_id
  task_definition = {
    frontend = {
      image          = module.ecr.frontend_repository_url
      container_port = 80
      cpu            = 256
      memory         = 512
      log_group_name = "/ecs/splunk-project/frontend"
      target_group   = module.alb.alb_target_group_arn["frontend"]
      environment    = {}
    }
    backend = {
      image          = module.ecr.backend_repository_url
      container_port = 3000
      cpu            = 256
      memory         = 512
      log_group_name = "/ecs/splunk-project/backend"
      target_group   = module.alb.alb_target_group_arn["backend"]
      environment = {

        "DATABASE_ENDPOINT" = module.rds.db_address,

        "DATABASE_USER" = var.db_username,


        "DATABASE_PASSWORD" = var.db_password,

        "FRONTEND_URL" = "http://${module.alb.alb_dns_name}"


      }
    }
  }
}
