#Setup 
#   1. 4 VMs Ubuntu 18.04, 1 control plane, 3 nodes.
#   2. Static IPs on individual VMs
#   3. /etc/hosts hosts file includes name to IP mappings for VMs
#   4. Swap is disabled
#   5. Take snapshots prior to installation, this way you can install 
#       and revert to snapshot if needed
#
ssh aen@c1-cp1


#Disable swap, swapoff then edit your fstab removing any entry for swap partitions
#You can recover the space with fdisk. You may want to reboot to ensure your config is ok. 
swapoff -a
vi /etc/fstab

#0 - Install Packages - docker, kubeadm, kubelet and kubectl
#Add Google's apt repository gpg key
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -


#Add the Kubernetes apt repository
sudo bash -c 'cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF'


#Update the package list and use apt-cache to inspect versions available in the repository
sudo apt-get update
apt-cache policy kubelet | head -n 20 


#Install the required packages, if needed we can request a specific version. 
#Use this version because in a later course we will upgrade the cluster to a newer version.
VERSION=1.21.0-00
sudo apt-get install -y docker.io kubelet=$VERSION kubeadm=$VERSION kubectl=$VERSION
sudo apt-mark hold docker.io kubelet kubeadm kubectl


#To install the latest, omit the version parameters
#sudo apt-get install docker.io kubelet kubeadm kubectl
#sudo apt-mark hold docker.io kubelet kubeadm kubectl


#Check the status of our kubelet and our container runtime, docker.
#The kubelet will enter a crashloop until it's joined. 
sudo systemctl status kubelet.service 
sudo systemctl status docker.service 


#Ensure both are set to start when the system starts up.
sudo systemctl enable kubelet.service
sudo systemctl enable docker.service


# Setup Docker daemon. This is a change that has been added since the recording of the course.
sudo bash -c 'cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF'


#Restart reload the systemd config and docker
sudo systemctl daemon-reload
sudo systemctl restart docker
