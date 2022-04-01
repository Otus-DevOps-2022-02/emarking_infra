#!/bin/bash

#This is script to automate install mogoDb server

apt-get update
apt-get install apt-transport-https ca-certificates
apt-get install -y apt-transport-https ca-certificates    echo "We are ready to install MongoDB Server"
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
apt-get update
echo "We are ready to install MongoDB Server"
apt-get install -y mongodb-org
systemctl start mongod
systemctl enable mongod
