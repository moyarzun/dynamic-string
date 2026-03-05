resource "aws_iam_role" "scheduler_role" {
  name = "dynamic_string_scheduler_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "scheduler.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "scheduler_policy" {
  name = "dynamic_string_scheduler_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["ec2:StopInstances"]
        Effect   = "Allow"
        Resource = aws_instance.web.arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "scheduler_attach" {
  role       = aws_iam_role.scheduler_role.name
  policy_arn = aws_iam_policy.scheduler_policy.arn
}
