# resource "aws_iam_policy" "sqs_policy" {
#   name        = "ecs-sqs-policy"
#   description = "Permissões para ECS acessar o SQS"
#   policy      = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow",
#         Action   = [
#           "sqs:CreateQueue",
#           "sqs:GetQueueAttributes",
#           "sqs:SendMessage",
#           "sqs:ReceiveMessage",
#           "sqs:DeleteMessage",
#           "sqs:GetQueueUrl"
#         ],
#         Resource = "*"
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "attach_sqs_policy" {
#   role       = "LabRole"
#   policy_arn = aws_iam_policy.sqs_policy.arn
# }
