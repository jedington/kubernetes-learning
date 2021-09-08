#!/bin/bash
# store in controller host '~/<this file>'
# example commands to setup controller

#- sudo apt remove ansible && sudo apt --purge autoremove 
# ^ if older/stale ansible version exists ^

sudo apt update
sudo apt upgrade
sudo apt install software-properties-common -y
sudo -E apt-add-repository -y 'ppa:deadsnakes/ppa'
sudo -E apt-add-repository -y 'ppa:ansible/ansible'
sudo apt update
sudo apt install python3.9 # will change w/ new versions
sudo apt install ansible -y
#- ansible --version | grep "python version" # optional