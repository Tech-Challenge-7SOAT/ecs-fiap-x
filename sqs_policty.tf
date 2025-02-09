resource "aws_iam_policy" "ecs_sqs_policy" {
  name        = "ecs-sqs-policy"
  description = "Permissões para acessar fila SQS"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = [
          "sqs:ListQueues",
          "sqs:GetQueueAttributes",
          "sqs:SendMessage"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:sqs:region:account-id:fiap-x-queue"
      }
    ]
  })
}
