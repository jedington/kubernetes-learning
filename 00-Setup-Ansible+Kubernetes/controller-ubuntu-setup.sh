#!/bin/bash
# example commands to setup controller
sudo apt-get update
sudo apt-get install software-properties-common -y
sudo -E apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible -y