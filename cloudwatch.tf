resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/fiapx-api"
  retention_in_days = 7
}