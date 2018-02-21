# server-cluster-container-install
This repository contains docker files and scripts to be used for installing Kaltura server as clustered enviroment 




#Deploying Kaltura Clusters Using docker containers

Below are instructions for deploying Kaltura Clusters using docker we used centos 6(RPM) as OS but could be changed in the future.

# Before You Get Started Notes
•	The docker principle states that containers are easy to build and that the image is already ready to deploy, in Kaltura we would like to achieve that but it is not possible as of now, since the Kaltura installation procedure requires shared nfs and connection between the containers, in the future we will try to minimize the procedure.
•	All post-run scripts accept answers-file automatically as parameter, this is used for silent-automatic installs. If you want please edit the file prior to the installation and then install
•	For Load Balancing we used Nginx with round robin
•	The LB is expecting two front end machines with specific host names, but this could be edited to whatever names you want
•	The machine host-names must the installation files host names, otherwise they will not work
•	All answer files must match to each other (in the future they should be on a single docker volume)
•	The Batch scripts simply follow the guide from github:

    https://github.com/kaltura/platform-install-packages/blob/Mercury-13.14.0/doc/rpm-cluster-deployment-instructions.md#backup-and-restore-practices

Combined with the Kaltura docker installation instruction:
    
    https://github.com/kaltura/platform-install-packages/blob/Mercury-13.14.0/doc/install-docker.md
    
•	Currently we use the docker link to connect the clusters , we are aware that this is legacy and we will move to docker network at a future time 
•	Docker documentation can be found in the docker website and in google but I am providing some important points:
•	Docker images are base state of a ready to deploy machine,
    o	Images can be created via docker build command
    o	Images can be pooled from docker hub



•	Containers are running states of images:
    
    	The creation of container from an image is done via the ‘docker run’ command
    	
•	The following flags will be used in the run command:
    
    	-h   the host name must be the same as in the answer file
        -d  detach flag, if this flag is not shown the current session will be locked to the container meaning you will have to stay in the container forever
    	--privileged   gives additional privileges to the containers (allows writing to the NFS)
    	--name  the container name will use us to link containers
    	–link <container> links the container to another running container (via host file)
    	
	Note that link is detracted, and we will migrate to network in the future
•	Docker exec is running a command on a running container you will see the following flag
    
    	-it  interactive mode allows you to see output of command
    	 
	Example: running  ‘docker exec -it mysql bash‘  will get you into the container bash 
# Pre-installation requirements 
Installed Docker Engine on a valid host(atomic-OS is recommended )
•	https://www.projectatomic.io/
•	If you would like to install widget on the atomic please use:
    
    	rpm-ostree  install vim
    	  
•	also, there are two version of docker on the atomic, we recommend using the latest, this can be achieved via:
        
        https://access.redhat.com/articles/2317361

