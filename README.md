# 🚀 Infraestrutura AWS ECS com Terraform

Este projeto utiliza **Terraform** para provisionar uma infraestrutura no **AWS ECS (Elastic Container Service)**, utilizando **Fargate** como provedor de execução. O objetivo é criar um cluster ECS, definir uma task, configurar um serviço ECS e habilitar o auto scaling.

---

## 📌 Tecnologias Utilizadas

- **Terraform** - Infraestrutura como código
- **AWS ECS (Fargate)** - Execução de containers serverless
- **AWS ECR** - Registro de imagens de containers
- **AWS VPC & Subnets** - Configuração de rede
- **AWS Security Groups** - Controle de tráfego de rede
- **AWS Auto Scaling** - Escalabilidade automática do serviço

---

## 📂 Estrutura do Projeto

```
├── main.tf          # Configuração principal do Terraform
├── variables.tf     # Definição de variáveis
├── outputs.tf       # Definição de outputs
├── README.md        # Documentação do projeto
```

---

## 🛠️ Recursos Criados

### 1️⃣ **ECS Cluster**
Criação de um cluster ECS chamado `ecs-fiap-x`:

```hcl
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "ecs-fiap-x"
}
```

### 2️⃣ **Task Definition**
Define uma task ECS Fargate, utilizando a imagem do **Amazon ECR**:

```hcl
resource "aws_ecs_task_definition" "ecs_task" {
  family                   = "ecs-task"
  execution_role_arn       = var.labRole
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"

  container_definitions = jsonencode([
    {
      name  = "ecs-container"
      image = "083261780098.dkr.ecr.us-east-1.amazonaws.com/fiapx-api/video:latest"
      portMappings = [{
        containerPort = 8080
        protocol      = "tcp"
      }]
      essential = true
    }
  ])
}
```

### 3️⃣ **ECS Service**
Criação do serviço ECS com rede pública e security group configurado:

```hcl
resource "aws_ecs_service" "ecs_service" {
  name            = "ecs-service"
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.ecs_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.aws_subnets.default.ids
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }
}
```

### 4️⃣ **Auto Scaling**
Define escalabilidade automática do serviço ECS:

```hcl
resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 5
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
```

### 5️⃣ **Configuração de Rede**
#### **VPC e Subnets**

```hcl
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
```

#### **Security Group**
Permite tráfego na porta 8080:

```hcl
resource "aws_security_group" "ecs_sg" {
  name        = "SG-${var.projectName}"
  description = "SG used for fiap-x project"
  vpc_id      = data.aws_vpc.default.id

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
```

---

## 📌 **Como Usar**

### 🔹 **Pré-requisitos**
- AWS CLI configurado com credenciais
- Terraform instalado
- Repositório ECR criado e imagem Docker já enviada

### 🚀 **Passos para Deploy**
1️⃣ **Inicialize o Terraform**
```sh
terraform init
```

2️⃣ **Valide a configuração**
```sh
terraform validate
```

3️⃣ **Crie o plano de execução**
```sh
terraform plan
```

4️⃣ **Aplique as mudanças**
```sh
terraform apply -auto-approve
```

5️⃣ **Verifique o status do ECS**
```sh
aws ecs list-clusters
aws ecs list-services --cluster ecs-fiap-x
```

---

## 📢 **Contribuição**
Sinta-se à vontade para abrir **issues** ou enviar **pull requests** para melhorias!

---

## 📜 **Licença**
Este projeto está sob a licença MIT.

