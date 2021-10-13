#!/bin/bash
# example commands to setup ssh--might need to change/add root@'s

# yes '' | ssh-keygen -t rsa -b 4096 -C "Kubenetes Key" -N '' > /dev/null
# # ^^ Completely no prompts or showing RSA token already made ^^

ssh-keygen -t rsa -b 2048 -C "Kubernetes Key" -N '' # <<<$'\n'
# ^^ better option, will prompt if it already exists ^^
ssh-copy-id -i $HOME/.ssh/id_rsa.pub root@c1-cp1
ssh-copy-id -i $HOME/.ssh/id_rsa.pub root@c1-node1
ssh-copy-id -i $HOME/.ssh/id_rsa.pub root@c1-node2
ssh-copy-id -i $HOME/.ssh/id_rsa.pub root@c1-node3
eval $(ssh-agent)
ssh-add
ansible -m ping all