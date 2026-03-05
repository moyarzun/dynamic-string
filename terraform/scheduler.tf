resource "aws_scheduler_schedule" "stop_ec2" {
  name       = "stop-dynamic-string-poc"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  # Automatically stop the instance 2 hours after the Terraform apply
  schedule_expression = "at(${replace(timeadd(timestamp(), "2h"), "Z", "")})"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = aws_iam_role.scheduler_role.arn

    input = jsonencode({
      InstanceIds = [aws_instance.web.id]
    })
  }
}
