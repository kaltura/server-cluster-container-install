# Batch Node
you can add as many Batch Front as you like, make sure to change the host name
## Run Command:
•	docker run --name @node name @ -h @host name@  -d --link @lb container name@ --link @mysql name@ --link @sphinx name@ --link @nfs name@ --privileged @image name@
    
    example :docker run --name batchfirstnode -h first-batch-host  -d --link docker-lb --link mysql --link sphinx --link kaltura-nfs --privileged roiebeck/server-cluster-container-install-batch
    
## Execute Command:
•	docker exec -it @batch container name@ /root/install/batch_settings.sh

    example: docker exec -it batchfirstnode /root/install/batch_settings.sh
