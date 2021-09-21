#!/bin/bash
# store in controller host '~/<this file>'

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
        package_manager=${osInfo[$f]}
    fi
done

sudo $package_manager update
sudo $package_manager upgrade
if [ $package_manager=="apt" ]
then
    sudo apt install software-properties-common -y
    sudo -E apt-add-repository -y 'ppa:deadsnakes/ppa'
    sudo -E apt-add-repository -y 'ppa:ansible/ansible'
    sudo apt update
fi

sudo $package_manager install git-all
sudo $package_manager install python3
sudo $package_manager update

#- sudo apt remove ansible && sudo apt --purge autoremove 
# ^ if older/stale ansible version exists ^
sudo $package_manager install ansible -y
#- ansible --version | grep "python version" # optional

# ip changes depending on vm setup
echo "
10.10.10.10 c1-cp1
10.10.10.11 c1-node1
10.10.10.12 c1-node2
10.10.10.13 c1-node3
" >> /etc/hosts