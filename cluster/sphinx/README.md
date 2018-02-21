# Sphinx Indexing server
you can add as many sphinx server as you like, make sure to change the host name

## Run command:
•	docker run -d  --link @mysql container name@  --name @container name@-h @sphinx-host--name@  @image name: version@
    
    	Example: docker run -d  --link mysql  --name sphinx1 -h docker-sphinx1-host  roiebeck/kaltura-sphinx:version1
then execute the following command:
•	docker exec -it @name of sphinx machine@ /root/install/sphinx_settings.sh
    
    	Example: docker exec -it sphinx1 /root/install/sphinx_settings.sh
