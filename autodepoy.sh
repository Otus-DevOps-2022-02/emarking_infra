#!/bin/bash


#This scrip will do auto-deploy

echo "Trying to yc init......"

yc compute instance create --name reddit-app  --hostname  reddit-app --zone ru-central1-a \
 --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts,size=10GB \
 --platform standard-v3  --cores=2  --core-fraction=20  --memory=4 --preemptible \
 --network-interface subnet-name=mynet,nat-ip-version=ipv4 \
 --metadata serial-port-enable=1  --metadata-from-file user-data=setting.yaml
