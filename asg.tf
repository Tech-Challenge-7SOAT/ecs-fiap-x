resource "aws_appautoscaling_target" "ecs_target" {
  max_capacity       = 5   # Número máximo de tasks
  min_capacity       = 1   # Número mínimo de tasks
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
