#!/bin/bash

yum update -y
amazon-linux-extras install nginx1 -y
yum install -y git


# install node and application for ec2-user
cd /home/ec2-user
git clone https://github.com/SafdarJamal/crud-app.git # Simple CRUD Example Web Application
chown ec2-user -R /home/ec2-user/
sudo -u ec2-user bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
sudo -u ec2-user bash -c '. ~/.nvm/nvm.sh && nvm install 16.10.0 && npm install --prefix /home/ec2-user/crud-app/'


# set up systemd service
cat << EOF > /etc/systemd/system/crud_website.service
[Unit]
Description=Manage crud website service
[Service]
WorkingDirectory=/home/ec2-user/crud-app/
ExecStart=/home/ec2-user/.nvm/versions/node/v16.10.0/bin/npm start
Environment="PATH=/home/ec2-user/.nvm/versions/node/v16.10.0/bin/:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
User=ec2-user
Type=simple
Restart=on-failure
RestartSec=10
[Install]
WantedBy=multi-user.target
EOF


systemctl daemon-reload; systemctl start crud_website.service 

sed -i "s/error_page 500 502 503 504 \/50x.html;/location \/ {/" /etc/nginx/nginx.conf
sed -i "s/location = \/50x.html {/proxy_pass http:\/\/localhost:3000;/" /etc/nginx/nginx.conf

systemctl enable nginx.service
systemctl start nginx.service