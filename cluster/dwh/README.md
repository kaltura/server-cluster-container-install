# DWH Node
## Run Command:
•	docker run --name @container name @ -h @host name -d --link @lb container name@ --link @MySQL container name@ --link @sphinx container name@ --link @NFS container name@ --privileged @Image Name@
    
    o example:	docker run --name dwh -h dwh-host  -d --link docker-lb --link mysql --link sphinx --link kaltura-nfs --privileged roiebeck/server-cluster-container-install-dwh

## Execute Command:
•	docker exec -it  @container name@ /root/install/dwh_settings.sh
   
   	o example: docker exec -it dwh /root/install/dwh_settings.sh
