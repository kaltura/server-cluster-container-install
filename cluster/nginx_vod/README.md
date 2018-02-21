# Nginx VOD

##Run Command:
•	docker run --name @container name @ -h @host name@ -p 88:88 -d --link @lb container name@ --link @MySQL container name@ --link @sphinx container name@ --link @NFS container name@ --privileged @Image Name@

    	example: docker run --name nginx_vod -h docker-packager -p 88:88 -d --link docker-lb --link mysql --link sphinx1 --link kaltura-nfs --privileged roiebeck/kaltura-nginx-vod:version1
##Execute Command:
•	docker exec -it  @container name@ /root/install/nginx_settings.sh
    
    	example: docker exec -it  nginx_vod /root/install/nginx_settings.sh
