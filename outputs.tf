output "ecs_cluster_name" {
  description = "Nome do cluster ECS"
  value       = aws_ecs_cluster.ecs_cluster.name
}

output "ecs_service_name" {
  description = "Nome do serviço ECS"
  value       = aws_ecs_service.ecs_service.name
}

output "ecs_task_definition_arn" {
  description = "ARN da definição da tarefa ECS"
  value       = aws_ecs_task_definition.ecs_task.arn
}