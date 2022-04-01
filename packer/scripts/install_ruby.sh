#!/bin/bash

#This script will install Ruby env to your server


echo "Starting to install Ruby env....."
sleep 100
apt-get  install software-properties-common
#apt-get --assume-yes update

apt-get --assume-yes install ruby-full ruby-bundler build-essential
