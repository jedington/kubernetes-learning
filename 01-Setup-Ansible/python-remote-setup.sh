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
fi

sudo $pkg_mgr update
sudo $pkg_mgr install python3 -y
sudo $pkg_mgr upgrade && sudo $pkg_mgr autoclean && sudo $pkg_mgr autoremove
