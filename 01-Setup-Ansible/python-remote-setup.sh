#!/bin/bash

declare -A osInfo;
osInfo[/etc/debian_version]='apt'
osInfo[/etc/alpine-release]='apk'
osInfo[/etc/centos-release]='yum'
osInfo[/etc/fedora-release]='dnf'
osInfo[/etc/redhat-release]='dnf'
# Newer RHEL/CentOS versions use 'dnf' from version 7.XX and forward
# Newer RedHat family versions use: '/etc/redhat/release' since 2013~2015
# Cannot guarantee compatibility for any RedHat systems older than 2015

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
		pkg_mgr=${osInfo[$f]}
    fi
done

sudo $pkg_mgr update

if [ $pkg_mgr=='apt' ]
then
    sudo apt install software-properties-common -y
    sudo -E apt-add-repository -y 'ppa:deadsnakes/ppa'
    sudo -E apt-add-repository -y 'ppa:ansible/ansible'
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

if [ $pkg_mgr=='yum'||'dnf' ]
then
    sudo $pkg_mgr clean packages && sudo $pkg_mgr clean metadata
    sudo $pkg_mgr clean dbcache && sudo $pkg_mgr clean all
    sudo $pkg_mgr makecache
fi

sudo $pkg_mgr update
sudo $pkg_mgr install python3 -y
sudo $pkg_mgr upgrade && sudo $pkg_mgr autoremove