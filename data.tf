data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_lb_target_group" "ecs_tg" {
  name = "ecs-target-group"
}

data "aws_security_group" "default_sg" {
  filter {
    name   = "group-name"
    values = ["default"]
  }
}