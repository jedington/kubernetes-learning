#!/bin/bash

declare -A osInfo;
osInfo[/etc/debian_version]="apt"
osInfo[/etc/alpine-release]="apk"
osInfo[/etc/centos-release]="yum"
osInfo[/etc/fedora-release]="dnf"
osInfo[/etc/redhat-release]="yum"
# newer versions of RHEL and CentOS will start to use 
# 'dnf' instead of 'yum' from version 8.XX and forward.

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
		pkg_mgr=${osInfo[$f]}
    fi
done

sudo $pkg_mgr update && sudo $pkg_mgr upgrade
if [ $pkg_mgr=="apt" ]
then
    sudo apt install software-properties-common -y
    sudo -E apt-add-repository -y 'ppa:deadsnakes/ppa'
    sudo -E apt-add-repository -y 'ppa:ansible/ansible'
fi

sudo $pkg_mgr update
sudo $pkg_mgr install git python3 ansible -y
sudo $pkg_mgr upgrade && sudo $pkg_mgr autoclean && sudo $pkg_mgr autoremove
ansible --version | grep "python version" # optional
#- sudo $pkg_mgr remove ansible && sudo $pkg_mgr --purge autoremove 
# ^ if older/stale ansible version exists ^

# ip changes depending on vm setup
while IFS= read -r line ; do
    if ! grep -Fqxe "$line" /etc/hosts ; then
        printf "%s\n" "$line" >> /etc/hosts
    fi
done <<- EOM

    ### ###### ###
    # /etc/hosts #
    # ## #### ## #

    10.10.10.10 c1-cp1
    10.10.10.11 c1-node1
    10.10.10.12 c1-node2
    10.10.10.13 c1-node3

EOM

# ansible_host=xxx.xxx.xxx.xxx ips change depending on vm setup
while IFS= read -r line ; do
    if ! grep -Fqxe "$line" /etc/ansible/hosts ; then
        printf "%s\n" "$line" >> /etc/ansible/hosts
    fi
done <<- EOM

    ### ### ###### ### ###
    # /etc/ansible/hosts #
    # ## ### #### ### ## #

    [controller]
    c1-cp1 ansible_host=10.10.10.10 ansible_user=root
    #- localhost ansible_host=127.0.0.1 ansible_user=root ansible_connection=local

    [nodes] # ip changes depending on vm setup
    c1-node1 ansible_host=10.10.10.11 ansible_user=root 
    c1-node2 ansible_host=10.10.10.12 ansible_user=root 
    c1-node3 ansible_host=10.10.10.13 ansible_user=root

EOM