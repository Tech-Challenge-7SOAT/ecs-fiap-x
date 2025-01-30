resource "aws_iam_role_policy" "ecs_s3_access" {
  name = "ecs-s3-access"
  role = var.labRole

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Resource = "${aws_s3_bucket.bucket_fiap_x.arn}/*"
      }
    ]
  })
}