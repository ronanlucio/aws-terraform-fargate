module "container_definition" {
  source = "git::https://github.com/cloudposse/terraform-aws-ecs-container-definition.git?ref=tags/0.58.1"

  container_name  = var.app_name
  container_image = "${aws_ecr_repository.default.repository_url}:${var.docker_image_version}"
}

resource "aws_ecs_task_definition" "default" {
  container_definitions    = module.container_definition.json_map_encoded
  family                   = var.app_name
  requires_compatibilities = [local.launch_type]

  cpu          = "256"
  memory       = "512"
  network_mode = "awsvpc"
}
