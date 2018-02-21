# Additional Front nodes
you can add as many additional Front as you like, make sure to change the host name,
also make sure to reconfigure the LB 

## Run Command:
•	docker run --name @container name@ -h @host name@ -d --link @MySQL container name@ --link sphinx container name@ --link @NFS container name@ --privileged @Image name@

	docker run --name fesecondnode -h second-front-host  -d --link mysql --link sphinx1 --link kaltura-nfs --privileged roiebeck/kaltura-fe-additional-nodes:version1

## Execute Command:
•	docker exec -it @Container name@ /root/install/fe_settings.sh

	example: docker exec -it fesecondnode /root/install/fe_settings.sh



#Important!!!  Stop and start the container 
   if you stop and start the container you will have to enter the FE container and add to the end of 
   /etc/hosts file the following:
   127.0.0.1    <name of docker-LB host>
    
       exmple: 127.0.0.1    docker-host
   