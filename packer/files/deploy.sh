#!/bin/bash


#This script will deploy rubby app in this server


cd /usr/local/src/

apt-get --assume-yes install git
git clone -b monolith https://github.com/express42/reddit.git

cd reddit && bundle install

touch /etc/systemd/system/puma.service

echo "[Unit]
Description=Puma HTTP Server
After=network.target
[Service]
Type=simple
WorkingDirectory=/usr/local/src/reddit
ExecStart=/usr/local/bin/puma
[Install]
WantedBy=multi-user.target" >> /etc/systemd/system/puma.service

chmod 664 /etc/systemd/system/puma.service

systemctl daemon-reload

systemctl enable puma.service

systemctl start puma.service
