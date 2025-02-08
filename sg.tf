resource "aws_security_group" "ecs_sg" {
  name        = "SG-${var.projectName}"
  description = "SG used for fiap-x project"
  vpc_id      = data.aws_vpc.default.id

  # Permite tráfego APENAS do ALB na porta 8080
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}