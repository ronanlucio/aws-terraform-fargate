data "aws_caller_identity" "default" {}

data "aws_ecr_authorization_token" "token" {}

resource "aws_ecr_repository" "default" {
  name                 = var.app_name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "docker_registry_image" "app" {
  name = "${aws_ecr_repository.default.repository_url}:latest"

  build {
    context = "../../"
  }
}