locals {
  aws_ecr_url      = "${data.aws_caller_identity.default.account_id}.dkr.ecr.${var.aws_region}.amazonaws.com"
  launch_type      = "FARGATE"
}

resource "aws_ecs_cluster" "default" {
  name = var.app_name
}

resource "aws_ecs_service" "default" {
  name        = var.app_name
  cluster     = aws_ecs_cluster.default.arn
  launch_type = local.launch_type

  deployment_maximum_percent         = 200
  deployment_minimum_healthy_percent = 0
  desired_count                      = 1
  task_definition                    = "${aws_ecs_task_definition.default.family}:${aws_ecs_task_definition.default.revision}"

  network_configuration {
    assign_public_ip = true
    security_groups  = data.aws_security_groups.default.ids
    subnets          = data.aws_subnets.default.ids
  }
}
