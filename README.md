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

1. Download Ubuntu VM template (any stable release after 18.04):
    - [VMWare/Hyper-V] https://ubuntu.com/download/desktop
    - [VirtualBox] https://www.osboxes.org/ubuntu/

2. Install kubernetes within each Node (1+X):
    - [NOTE] You will need to be aware of what the IPs of each Node are, and to change where/if applicable.
    - [Option-1-(Ansible)] Use Ansible instead of manually copying. What this will do, is run a script on each node that automates most of the installation and configuration of Kubernetes. This won't automate everything, but will skip a good amount of redundant hassle.
        1. Clone repo and navigate into the Controller Node / Control Plane Node (c1-cp1). 
            - [Example] CLI/run: `git clone jedington/kubernetes-learning.git`.
        2. Copy from '../01-Setup-Ansible/(copy-files-here)' to Controller Node '~/(paste-files-here)'. 
        3. Run - `sudo controller-setup.sh` - to install latest python and ansible. 
            - [NOTE] Keep in mind you'll have to adjust the IP addresses in the 'echo' of 'controller-setup.sh' to reflect your Node IPs.
        4. Figure out auth for remote hosts, can use 'ssh-setup-example.sh'.
            - [Example] CLI/run: `sudo ssh-setup-example.sh`.
        5. Finally, run the Ansible playbook from the Controller Node.
            - [Example] CLI/run: `sudo ansible-playbook -i ~/ all-setup.yml` 
        6. Refer to '../01-PluralSight-Fundamentals/03/Demos/1-CreateControlPlaneNode-containerd.sh' and complete the setup from there.
        7. Continue to Step 4. Keep in mind that much of installing Kubernetes has been automated, now its just further configuring the control node and running it.
    - [Option-2-(SSH)] This option is arguably the fastest (but not automated) if you're fully comfortable with multi-SSH clients and using 'git' to remotes.
        1. Clone repo in a preferred local directory. CLI/run: `git clone jedington/kubernetes-learning.git`
        2. Navigate into each node and drop the '../01-Setup-Ansible/kubernetes-ubuntu-setup.sh' file into them, then execute the file for each node.
        3. Figure out auth for remote hosts, can use 'ssh-setup-example.sh'.
            - [Example] CLI/run: `sudo ssh-setup-example.sh`.
        4. Refer to '../02-PluralSight-Fundamentals/03/Demos/1-CreateControlPlaneNode-containerd.sh' and complete the setup from there.
        5. Continue to Step 4. Keep in mind that much of installing Kubernetes has been done, now its just further configuring the control node and running it.
    - [Option-3-(Docker)] This option is completely manual, using  original exercise instructions:
        1. Use this path for Docker setup: '../02-PluralSight-Fundamentals/03/demos/docker (alternative)'
        2. Continue to Step 4.

### [PluralSight] Kubernetes Fundamentals by [Anthony Nocentino](https://app.pluralsight.com/profile/author/anthony-nocentino)

3. Navigate files from: 02-PluralSight-Fundamentals > 03 > installing-and-configuring-kubernetes-slides.pdf
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
[linkedin-url]: https://www.linkedin.com/in/julian-edington/
[twitter-shield]: https://img.shields.io/twitter/follow/arcanicvoid?style=for-the-badge&logo=twitter&colorB=555
[twitter-url]: https://twitter.com/arcanicvoid