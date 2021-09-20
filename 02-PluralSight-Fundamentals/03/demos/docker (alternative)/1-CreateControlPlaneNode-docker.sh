#Only on the Control Plane Node, download the yaml files for the pod network.
#The calico yaml file has changed since the publication of the course and is now avaialble at the URL below.
wget https://docs.projectcalico.org/manifests/calico.yaml


#Look inside calico.yaml and find the network range CALICO_IPV4POOL_CIDR, 
#adjust if needed for your infrastructure to ensure that the Pod network IP range doesn't overlap with other networks
vi calico.yaml

#0 - Creating a Cluster

#Create our kubernetes cluster, specify a pod network range matching that in calico.yaml! 
#Use the same version you specified in 0-PackageInstallation-docker.sh
sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --kubernetes-version 1.21.0


#If you want to install the latest, omit the kubernetes-version parameter
#sudo kubeadm init --pod-network-cidr=192.168.0.0/16


#Configure our account on the Control Plane Node to have admin access to the API server from a non-privileged account.
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

#1 - Creating a Pod Network
#Deploy yaml file for your pod network. #May print a warning about PodDisruptionBudget it is safe to ignore for now.
kubectl apply -f calico.yaml


#Look for the all the system pods and calico pods to change to Running. 
#The DNS pod won't start until the Pod network is deployed and Running.
kubectl get pods --all-namespaces


#Gives you output over time, rather than repainting the screen on each iteration.
kubectl get pods --all-namespaces --watch


#All system pods should be Running
kubectl get pods --all-namespaces


#Get a list of our current nodes, just the Control Plane Node.
kubectl get nodes 

#2 - systemd Units...again!
#Check out the systemd unit
#Remember the kubelet starts the static pods, and thus the control plane pods
sudo systemctl status kubelet.service 


#check out the directory where the kubeconfig files live
ls /etc/kubernetes


#3 - Static Pod manifests
#let's check out the manifests on the Control Plane Node
ls /etc/kubernetes/manifests


#And look more closely at API server and etcd's manifest.
sudo more /etc/kubernetes/manifests/etcd.yaml
sudo more /etc/kubernetes/manifests/kube-apiserver.yaml
