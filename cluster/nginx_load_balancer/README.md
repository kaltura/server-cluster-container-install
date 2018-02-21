# Nginx LB node
Run Command:
    Note: --link @FE 1 container Name@  … --link @FE n container Name@ all containers names
•	docker run -d --link @FE 1 container Name@  … --link @FE n container Name@ --name=docker-lb -h docker-host -p 80:80 -p 443:443 -p 1935:1935 @image name@

    example: docker run -d --link fefirstnode --link fesecondnode  --name=docker-lb -h docker-host -p 80:80 -p 443:443 -p 1935:1935 roiebeck/load-balancer-nginx:version1



### Note:
•	 if you add additional FE nodes you will need to follow this stages
    1.stop and remove container
    2. start container(docker run) add the  --link to the new FE flag
    3. edit the /etc/nginx/conf.d/default.conf file in the container and restart the nginx service 
        
        Link:  http://blog.tobiasforkel.de/en/2016/08/18/reload-nginx-inside-docker-container/
