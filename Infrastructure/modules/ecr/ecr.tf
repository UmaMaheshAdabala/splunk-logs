resource "aws_ecr_repository" "this" {
  for_each = var.ecr_repo
  name     = "${var.name}-${each.value}"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

}

