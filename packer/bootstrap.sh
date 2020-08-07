#!/bin/bash
sudo apt-get update
#Grub update forces interactive that is why this seemingly crazy
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -q -y -u -o Dpkg::Options::="--force-confdef" --allow-downgrades --allow-remove-essential --allow-change-held-packages --allow-change-held-packages --allow-unauthenticated;
sudo apt-get install -y python3-distutils jq unzip && curl -k -s https://bootstrap.pypa.io/get-pip.py | sudo python3
sudo pip install ansible