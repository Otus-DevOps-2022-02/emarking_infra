#!/bin/bash

#This is script to automate install mogoDb server

sudo apt-get install -y apt-transport-https ca-certificates
lsb_release -c | while read line

do

if  grep -q "bionic" <<< $line

then echo "Yor Ubuntu linux  $line"
     echo "Starting MongoDB insatlation Progress...."
     keyadd=`wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -`
     echo "Import the public key is: $keyadd"
     echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
     echo "Adding MongoDB repository to source list is Done!"
     sudo apt-get update
     echo "We are ready to install MongoDB Server"
     sleep 5
     sudo apt-get install -y mongodb-org
     sudo systemctl start mongod
     sudo systemctl enable mongod
     sudo systemctl status mongod | grep "enabled"
     sudo systemctl status mongod | grep "active"

elif grep -q "focal" <<< $line

then echo "Yor Ubuntu linux  $line"
     echo "Starting MongoDB insatlation Progress...."
     keyadd=`wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -`
     echo "Import the public key is: $keyadd"
     echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
     echo "Adding MongoDB repository to source list is Done!"
     sudo apt-get update
     echo "We are ready to install MongoDB Server"
     sleep 5
     sudo apt-get install -y mongodb-org
     sudo systemctl start mongod
     sudo systemctl enable mongod
     sudo systemctl status mongod | grep "enabled"
     sudo systemctl status mongod | grep "active"

elif grep -q "xenial" <<< $line

then echo "Yor Ubuntu linux  $line"
     echo "Starting MongoDB insatlation Progress...."
     keyadd=`wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -`
     echo "Import the public key is: $keyadd"
     echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
     echo "Adding MongoDB repository to source list is Done!"
     sudo apt-get update
     echo "We are ready to install MongoDB Server"
     sleep 5
     sudo apt-get install -y mongodb-org
     sudo systemctl start mongod
     sudo systemctl enable mongod
     sudo systemctl status mongod | grep "enabled"
     sudo systemctl status mongod | grep "active"


else  echo "Sorry, this script is not support ypurs Linux version"

fi

done
