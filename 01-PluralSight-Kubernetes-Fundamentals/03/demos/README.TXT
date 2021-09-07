***All demos have been tested against Ubuntu 18.04 and Kubernetes 1.21.0***
***Please use 1.21 as this is the current version for the exam. 1.22 introduces some breaking changes. I will release those changes when 1.22 becomes available.

There may be slight differences in the code from what's in the video course, but the concepts are all the same.

* Update 10 Aug 2021 
 * Updated the kubernetes version to 1.21.0 on the containerd demos
   * In 0-PackageInstallation-containerd.sh, 1-CreateControlPlaneNode-containerd.sh and 2-CreateNodes-containerd.sh all reference 1.21 now.
   * Please use this version as this is the current version for the exam. 1.22 introduces some breaking changes.
   * Added code to set the node name in ClusterConfiguration.yaml in 1-CreateControlPlaneNode-containerd.sh

 * Updated the kubernetes version to 1.21.0 on the docker demos
   * In 0-PackageInstallation-docker.sh, 1-CreateControlPlaneNode-docker.sh and 2-CreateNodes-dockerdocker.sh all reference 1.21 now.
   
   * Added code to set the node name in ClusterConfiguration.yaml in 1-CreateControlPlaneNode-containerd.sh

If you have any issues please feel free to reach out in the course discussion page and 

aen@centinosystems.com or in the course discussion page at www.pluralsight.com

