resource "aws_scheduler_schedule" "stop_ec2" {
  name       = "stop-dynamic-string-poc"
  group_name = "default"

  flexible_time_window {
    mode = "OFF"
  }

  # Based on current local timezone GMT -03:00, 18:00 Local is 21:00 UTC.
  # Using UTC to avoid any AWS generic region TZ issues. 
  schedule_expression = "cron(0 21 * * ? *)"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = aws_iam_role.scheduler_role.arn

    input = jsonencode({
      InstanceIds = [aws_instance.web.id]
    })
  }
}
