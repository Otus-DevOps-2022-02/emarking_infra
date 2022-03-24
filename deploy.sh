#!/bin/bash


#This script will deploy rubby app in this server


cd /usr/local/src/

sudo apt-get updte

sudo apt-get install git

git clone -b monolith https://github.com/express42/reddit.git

cd reddit && bundle install
