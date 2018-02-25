# NFS node
###Run command:
•	docker run -d --storage-opt size=120G --net=bridge --privileged --name @container name@ -h @host name@ @image name:tag@
    	
    	example: : docker run -d --storage-opt size=120G --net=bridge --privileged --name kalt-nfs -h kalt-nfs roiebeck/server-cluster-container-install-nfs
 
###Notes:
  
•	All containers must run with docker ‘--privileged’ flag in order to connect to NFS
•	--storage-opt size=120G give the NFS container root partition  120 GB of space.
