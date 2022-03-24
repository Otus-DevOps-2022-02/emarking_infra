#!/bin/bash


#This script will deploy rubby app in this server


cd /usr/local/src/


git clone -b monolith https://github.com/express42/reddit.git

cd reddit && bundle install

puma -d
