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

### PluralSight Kubernetes Fundamentals by [Anthony Nocentino](https://app.pluralsight.com/profile/author/anthony-nocentino)

1. download Ubuntu VM template (any stable release):
- https://ubuntu.com/download/desktop -- for VMWare/Hyper-V
- https://www.osboxes.org/ubuntu/ -- for VirtualBox

2. clone repo within a preferred local folder:
- git clone jedington/kubernetes-learning.git

3. install kubernetes within each VM (1+X):
- Manually move files, then CLI: 'sudo kubernetes-ubuntu-setup.sh'
- [optional] Use Ansible instead of manually copying. What this will do, is run a script on each node that almost automates the installation and configuration of Kubernetes. This won't automate everything, so you'll still have to refer to the instructions in step 5.
    1. Copy files from this repo /00-Setup-Ansible/ into Controller Host.
    2. Run controller-setup.sh to install latest python and ansible.
    3. Figure out auth for remote hosts, can refer to ssh-setup-example.sh. Keep in mind you'll have to adjust the IP addresses in the 'echo' of controller-setup.sh to reflect your VM node IPs.
    4. Run 'sudo ansible-playbook -i ~/ all-setup.yml' while in the Controller Host.
    5. Refer to '01-PluralSight-Kubernetes-Fundamentals > 03 > Demos > 1-CreateControlPlaneNode-containerd.sh' and complete the setup from there.

4. navigate through the files, starting from: 
- kubernetes learning > 01-PluralSight-Kubernetes-Fundamentals > 03 >

5. open the pdf, it'll guide through the rest:
- installing-and-configuring-kubernetes-slides.pdf


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/jedington/Canvas-Your-Goals.svg?style=for-the-badge
[contributors-url]: https://github.com/jedington/Canvas-Your-Goals/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/jedington/Canvas-Your-Goals.svg?style=for-the-badge
[forks-url]: https://github.com/jedington/Canvas-Your-Goals/network/members
[stars-shield]: https://img.shields.io/github/stars/jedington/Canvas-Your-Goals.svg?style=for-the-badge
[stars-url]: https://github.com/jedington/Canvas-Your-Goals/stargazers
[issues-shield]: https://img.shields.io/github/issues/jedington/Canvas-Your-Goals.svg?style=for-the-badge
[issues-url]: https://github.com/jedington/Canvas-Your-Goals/issues
[license-shield]: https://img.shields.io/github/license/jedington/Canvas-Your-Goals.svg?style=for-the-badge
[license-url]: https://github.com/jedington/Canvas-Your-Goals/blob/master/LICENSE
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/julian-edington/
[twitter-shield]: https://img.shields.io/twitter/follow/arcanicvoid?style=for-the-badge&logo=twitter&colorB=555
[twitter-url]: https://twitter.com/arcanicvoid
