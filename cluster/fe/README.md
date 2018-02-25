# The First Front node
## Run Command:
•   docker run --name @name @ -h @host name@ -d  --link @MySQL container name @ --link @sphinx container name@ --link @NFS container name@ --privileged @Image name@
    
    Example:  docker run --name fefirstnode -h first-front-host  -d  --link mysql --link sphinx --link kaltura-nfs  --privileged roiebeck/server-cluster-container-install-front-end-first-node

## Execute Command:
•	docker exec -it @container name@ /root/install/fe_settings.sh

	example: docker exec -it fefirstnode /root/install/fe_settings.sh

## Execute Command:
docker exec -it @container name@ /root/install/fe_db_settings.sh

	example: docker exec -it fefirstnode /root/install/fe_db_settings.sh

#Important!!!  Stop and start the container 
   if you stop and start the container you will have to enter the FE container and add to the end of 
   /etc/hosts file the following:
   127.0.0.1    <name of docker-LB host>
    
       exmple: 127.0.0.1    docker-host
       