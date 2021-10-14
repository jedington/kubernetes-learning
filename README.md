<!-- PROJECT SHIELDS -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
[![Twitter][twitter-shield]][twitter-url]

# kubernetes-learning

Recommended Knowledge Beforehand:
- Basics of VM tools: VMware / Hyper-V / Virtualbox.
- Linux: using commands, vi text editors.
- Foundational DevOps understanding.

1. Download Ubuntu VM template, preferrably version 18.04:
    - [VMware / Hyper-V](https://ubuntu.com/download/desktop)
    - [VirtualBox](https://www.osboxes.org/ubuntu)

2. Create four VMs using either VMware / Hyper-V / Virtualbox.
    - Pick one to be the controller, doesn't matter which; the rest will be remotes.
    - [NOTE] You will need to be aware of what the IPs of each VM / Node are.

3. Install kubernetes within each Node (1+X):
    - [Option-1-(Ansible)] This is the fastest option, contrary to how long these instructions are 😊. Use Ansible instead of manually copying. What this will do, is run a script on each node that automates most of the installation and configuration of Kubernetes. This won't automate everything, but will skip a good amount of redundant hassle.
        1. Navigate into the Controller Node / Control Plane Node (c1-cp1) and install git.
            1. [Run] `sudo apt update`
            2. [Run] `sudo apt install git -y`
        2. Clone repo into the Controller Node / Control Plane Node (c1-cp1).
            - [Run] `git clone https://github.com/jedington/kubernetes-learning.git ~/kubernetes-learning/`.
        3. Changing permissions to allow execution of scripts to setup Ansible.
            - [Run] `sudo chmod -R 755 ~/kubernetes-learning/01-Setup-Ansible`        
        4. Replace the default Ansible 'ansible.cfg' (configuration) file with our own.
            - [Run] `sudo cp -f ~/kubernetes-learning/01-Setup-Ansible/ansible.cfg /etc/ansible/ansible.cfg`
        5. Run - `controller-setup.sh` - to install latest python and ansible. 
            1. [NOTE] You'll have to adjust IPs in the 'echo' of 'controller-setup.sh' to your Node IPs.
                - [Run] `sudo vi ~/kubernetes-learning/01-Setup-Ansible/controller-setup.sh`
                - [REQUIRED] Edit IPs to reflect your VMs. Two locations in the file to change per Node.
                - Example
                    ```
                    ...
                    10.10.10.10 c1-cp1
                    10.10.10.11 c1-node1
                    10.10.10.12 c1-node2
                    10.10.10.13 c1-node3
                    ...
                    c1-node1 ansible_host=10.10.10.11 ansible_user=root 
                    c1-node2 ansible_host=10.10.10.12 ansible_user=root 
                    c1-node3 ansible_host=10.10.10.13 ansible_user=root
                    ...
                    ```
            2. [Run] `sudo ~/kubernetes-learning/01-Setup-Ansible/controller-setup.sh`
        6. Figure out auth for remote hosts, can use 'ssh-setup-example.sh'.
            - [Run] `sudo ~/kubernetes-learning/01-Setup-Ansible/ssh-setup-example.sh`.
            - [Note] this will prompt for the default passwords for each VM.
        7. Finally, run the Ansible playbook from the Controller Node.
            - [Run] `sudo ~/kubernetes-learning/01-Setup-Ansible/ansible-playbook all-setup.yml` 
        8. Refer to '../01-PluralSight-Fundamentals/03/Demos/1-CreateControlPlaneNode-containerd.sh' and complete setup of the Control Plane Node from there.
        9. Continue to Step 4. Keep in mind that much of installing Kubernetes has been automated, now its just further configuring the control node and running it.
    - [Option-2-(SSH)] This option is arguably quick (but not automated) if you're fully comfortable with SSH into clients and using 'git' to remotes. This option still automates the Kubernetes install, but you have to SSH to each Node.
        1. [All-Nodes] Install git.
            1. [Run] `sudo apt update`
            2. [Run] `sudo apt install git -y`
        2. [All-Nodes] Clone repo in a preferred local directory.
            - [run] `git clone https://github.com/jedington/kubernetes-learning.git ~/kubernetes-learning/`.
        3. [All-Nodes] Changing permissions to allow execution of scripts.
            - [Run] `sudo chmod -R 755 ~/kubernetes-learning/01-Setup-Ansible`
        4. [All-Nodes] Run the Kubernetes setup file.
            - [Run] `sudo ~/kubernetes-learning/01-Setup-Ansible/kubernetes-ubuntu-setup.sh`.
        5. [Control-Plane-Node-only] Refer to '../01-PluralSight-Fundamentals/03/Demos/1-CreateControlPlaneNode-containerd.sh' and complete setup of the Control Plane Node from there.
        6. Continue to Step 4. Keep in mind that much of installing Kubernetes has been done, now its just further configuring the control node and running it.
    - [Option-3] Going the normal route and no automation. This will take the longest.
        - Continue to Step 4.

### [PluralSight] Kubernetes Fundamentals by [Anthony Nocentino](https://app.pluralsight.com/profile/author/anthony-nocentino)

4. Navigate files from: 02-PluralSight-Fundamentals > 03 > installing-and-configuring-kubernetes-slides.pdf
    - [NOTE] Control Plane Node's IP address will vary; what's used as an example in the upcoming exercise files is: '172.16.94.10'
    - [NOTE] Removed redundant files due to this repo's 'kubernetes-ubuntu-setup.sh' eliminating the need for '0-PackageInstallation-containerd.sh' and '2-CreateNodes-containerd.sh'.

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/jedington/kubernetes-learning.svg?style=for-the-badge
[contributors-url]: https://github.com/jedington/kubernetes-learning/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/jedington/kubernetes-learning.svg?style=for-the-badge
[forks-url]: https://github.com/jedington/kubernetes-learning/network/members
[stars-shield]: https://img.shields.io/github/stars/jedington/kubernetes-learning.svg?style=for-the-badge
[stars-url]: https://github.com/jedington/kubernetes-learning/stargazers
[issues-shield]: https://img.shields.io/github/issues/jedington/kubernetes-learning.svg?style=for-the-badge
[issues-url]: https://github.com/jedington/kubernetes-learning/issues
[license-shield]: https://img.shields.io/github/license/jedington/kubernetes-learning.svg?style=for-the-badge
[license-url]: https://github.com/jedington/kubernetes-learning/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/julian-edington
[twitter-shield]: https://img.shields.io/twitter/follow/arcanicvoid?style=for-the-badge&logo=twitter&colorB=555
[twitter-url]: https://twitter.com/arcanicvoid