#!/bin/bash

#This script will install Ruby env to your server


echo "Starting to install Ruby env....."
sleep 5

sudo apt install -y ruby-full ruby-bundler build-essential

rv=`ruby -v`

echo "Your ruby version is: $rv"

bv=`bundler -v`

echo "Your bundler version is: $bv"
