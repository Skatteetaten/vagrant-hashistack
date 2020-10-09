#!/bin/bash

echo "Rewiring copied paths ´/etc/ansible´ onto their mounted git-source ´/box/ansible´"
sudo mv /etc/ansible /etc/ansible.packaged
sudo ln -s /box/ansible /etc/ansible
