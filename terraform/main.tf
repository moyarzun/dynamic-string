resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux_2023_arm.id
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = data.aws_subnets.default.ids[0]

  user_data = templatefile("${path.module}/scripts/setup.sh", {
    python_app    = file("${path.module}/../src/app.py")
    html_frontend = file("${path.module}/../src/templates/index.html")
  })

  tags = {
    Name = var.project_name
  }
}
