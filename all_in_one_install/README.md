# Deploying Kaltura Clusters Using docker containers

### Running this script will deploy a full Kaltura clustered solution using docker on a single host machine 
 
### Pre-installation requirements 
• Installed Docker Engine on a valid host(atomic-OS is recommended):

    https://www.projectatomic.io/
 
• If you would like to install widget on atomic please use:

    rpm-ostree install <name> 
    example: rpm-ostree install vim
    
• There are two version of docker on the atomic, we recommend using the latest, this can be achieved via:
     
    https://access.redhat.com/articles/2317361


### Pre-requirement
 
• root access(sudo) on Host machine

• all the files pulled from github, use the following link:
   https://github.com/kaltura/server-cluster-container-install   

• please make sure the all in one install folder has rw permissions, example :

    example: chmod 755 -R /var/roothome/test/all_in_one_install/
 
• dos2Unix installed on host, please active dos2unix on the document 
        
    example: dos2unix /var/roothome/test/all_in_one_install/install.sh  

### Installation
 
• simply run the install.sh file as root file must run from inside the parent folder(cluster install)


 
     


