variable "aws_region" {
  type = string
}

variable "app_name" {
  type = string
}

variable "terraform_state_bucket" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "docker_image_version" {
  description = "Version number or SHA to tag the built and pushed app docker image"
  type        = string
  default     = "latest"
}