#!/bin/bash

declare -A osInfo;
osInfo[/etc/debian_version]='apt'
osInfo[/etc/alpine-release]='apk'
osInfo[/etc/centos-release]='yum'
osInfo[/etc/fedora-release]='dnf'
osInfo[/etc/redhat-release]='dnf'
# Newer RHEL/CentOS versions use: 'dnf' from version 7.XX and forward
# Newer RedHat family versions use: '/etc/redhat/release' since 2013~2015
# Cannot guarantee compatibility for any RedHat systems older than 2015

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        pkg_mgr=${osInfo[$f]}
    fi
done

if [ $pkg_mgr=='yum'||'dnf' ]
then
    sudo $pkg_mgr clean packages && sudo $pkg_mgr clean metadata
    sudo $pkg_mgr clean dbcache && sudo $pkg_mgr clean all
    sudo $pkg_mgr makecache
fi

sudo $pkg_mgr update

if [ $pkg_mgr=='apt' ]
then
    sudo apt install software-properties-common -y
    sudo -E apt-add-repository 'ppa:deadsnakes/ppa' -y
    sudo -E apt-add-repository 'ppa:ansible/ansible' -y
    sudo apt autoclean
fi

if [ $pkg_mgr=='yum' ]
then
    sudo yum install https://repo.ius.io/ius-release-el$(rpm -E '%{rhel}').rpm -y
    line='clean_requirements_on_remove=1'
    file='/etc/yum.conf'
    grep -qxF "$line" "$file" || echo "$line" >> "$file"
fi

if [ $pkg_mgr=='dnf' ]
then
    sudo yum install epel-release -y && sudo yum install dnf -y
    line1='metadata_timer_sync=3600'
    line2='max_parallel_downloads=10'
    file='/etc/dnf/dnf.conf'
    grep -qxF "$line1" "$file" || echo "$line1" >> "$file"
    grep -qxF "$line2" "$file" || echo "$line2" >> "$file"
fi

sudo $pkg_mgr update
sudo $pkg_mgr install git python3 ansible -y
sudo $pkg_mgr upgrade && sudo $pkg_mgr autoremove
ansible --version | grep "python version" # optional

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

    # will rely on the playbook user specifications as preference

    [controller]
    c1-cp1 ansible_host=10.10.10.10 #- ansible_user=root
    #- localhost ansible_host=127.0.0.1 ansible_user=root ansible_connection=local

    [nodes] # ip changes depending on vm setup
    c1-node1 ansible_host=10.10.10.11 #- ansible_user=root 
    c1-node2 ansible_host=10.10.10.12 #- ansible_user=root 
    c1-node3 ansible_host=10.10.10.13 #- ansible_user=root

EOM