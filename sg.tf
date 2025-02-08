resource "aws_security_group" "ecs_sg" {
  name        = "SG-${var.projectName}"
  description = "Security Group for ECS tasks"
  vpc_id      = data.aws_vpc.default.id

  # Permite tráfego APENAS do ALB na porta 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}