#!/bin/bash

#This script will install Ruby env to your server


echo "Starting to install Ruby env....."

sudo apt-get --assume-yes update

sudo apt-get --assume-yes install ruby-full ruby-bundler build-essential
