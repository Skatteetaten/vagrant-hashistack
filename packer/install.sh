#!/bin/bash
apt-get update
# Grub update forces interactive that is why this seemingly crazy
# SKIPPING UPGRADES:
# You may comment the following line in order to disable system wide upgrade.
DEBIAN_FRONTEND=noninteractive apt-get upgrade --no-install-recommends -q -y -u -o Dpkg::Options::="--force-confdef" --allow-downgrades --allow-remove-essential --allow-change-held-packages --allow-change-held-packages --allow-unauthenticated;
apt-get install --no-install-recommends -y python3-distutils jq unzip && curl -k -s https://bootstrap.pypa.io/get-pip.py | sudo -H python3
pip install ansible