resource "aws_appautoscaling_policy" "ecs_cpu_policy" {
  name               = "ecs-cpu-policy"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value       = 50.0  # Quando passar de 50% de CPU, escala
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
    scale_in_cooldown  = 300  # Tempo mínimo entre diminuições (segundos)
    scale_out_cooldown = 60   # Tempo mínimo entre aumentos (segundos)
  }
}
