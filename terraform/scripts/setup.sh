#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

dnf update -y
dnf install -y python3 python3-pip
pip3 install flask

mkdir -p /home/ec2-user/app/templates

# The Python app and HTML are injected via Terraform templatefile
cat << 'EOF' > /home/ec2-user/app/app.py
${python_app}
EOF

cat << 'EOF' > /home/ec2-user/app/templates/index.html
${html_frontend}
EOF

chown -R ec2-user:ec2-user /home/ec2-user/app

cat << 'EOF' > /etc/systemd/system/flaskapp.service
[Unit]
Description=Flask Dynamic String API
After=network.target

[Service]
User=root
WorkingDirectory=/home/ec2-user/app
ExecStart=/usr/bin/python3 app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable flaskapp
systemctl start flaskapp
