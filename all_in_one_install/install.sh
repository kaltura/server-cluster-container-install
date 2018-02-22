#!/bin/bash
#===============================================================================
#          FILE: install.sh
#         USAGE: ./install.sh
#   DESCRIPTION:
#       OPTIONS: ---
# 	LICENSE: AGPLv3+
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR:Roie Beck, <Roie.Beck@kaltura.com>
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 02/13/18 10:48 EST
#      REVISION:  ---
#===============================================================================

set -eu

# set SElinux enforcement to permissive
setenforce permissive

#Give execution/read Permissions to the all the current files in docker cluster

chmod -R 755 ../

##
## pull all the latest required images
##
docker pull roiebeck/server-cluster-container-install-nfs
docker pull roiebeck/server-cluster-container-install-mysql
docker pull roiebeck/server-cluster-container-install-front-end-first-node
docker pull roiebeck/server-cluster-container-install-front-end-additional-nodes
docker pull roiebeck/server-cluster-container-install-batch
docker pull roiebeck/server-cluster-container-install-dwh
docker pull roiebeck/server-cluster-container-install-nginx_load_balancer
docker pull roiebeck/server-cluster-container-install-nginx_vod
docker pull roiebeck/server-cluster-container-install-sphinx

##
## run nfs container
##
docker run -d --storage-opt size=120G --net=bridge --privileged --name kaltura-nfs -h kaltura-nfs roiebeck/server-cluster-container-install-nfs

##
## run mysql container
##
docker run --name mysql -d -h docker-mysql-host roiebeck/server-cluster-container-install-mysql

##
## run sphinx container
##
docker run -d --name sphinx --link mysql -h docker-sphinx1-host  roiebeck/server-cluster-container-install-sphinx

##
## exec configuration on sphinx machine
##
docker exec -it sphinx /root/install/sphinx_settings.sh

##
## run fe first node configuration
##
docker run --name fefirstnode --link mysql --link sphinx --link kaltura-nfs -h first-front-host -d --privileged roiebeck/server-cluster-container-install-front-end-first-node

##
## configure the fist front node
##
docker exec -it fefirstnode /root/install/fe_settings.sh

##
## configure the db of fist front node
##
docker exec -it fefirstnode /root/install/fe_db_settings.sh


##
## run fe first node configuration
##
docker run --name fesecondnode --link mysql --link sphinx --link kaltura-nfs -h second-front-host -d --privileged roiebeck/server-cluster-container-install-front-end-additional-nodes

##
## configure second node
##
docker exec -it fesecondnode /root/install/fe_settings.sh

##
## load balancer NGINX
##
docker run -d --link fefirstnode --link fesecondnode  --name=docker-lb -h docker-host -p 80:80 -p 443:443 -p 1935:1935 roiebeck/server-cluster-container-install-nginx_load_balancer

##
## run the first batch node
##
docker run --name batchfirstnode -h first-batch-host  -d --link docker-lb --link mysql --link sphinx --link kaltura-nfs --privileged roiebeck/server-cluster-container-install-batch

##
## configure the first batch node
##
docker exec -it batchfirstnode /root/install/batch_settings.sh

##
## run the second batch node
##
docker run --name batchsecondnode -h second-batch-host  -d --link docker-lb --link mysql --link sphinx --link kaltura-nfs --privileged roiebeck/server-cluster-container-install-batch

##
## configure the second batch node
##
docker exec -it batchsecondnode /root/install/batch_settings.sh

##
## run NGINX vod packager configuration
##
docker run --name nginx_vod -h docker-packager -p 88:88 -d --link docker-lb --link mysql --link sphinx --link kaltura-nfs --privileged docker pull roiebeck/server-cluster-container-install-nginx_vod

##
## execute configuration on node
##
docker exec -it  nginx_vod /root/install/nginx_settings.sh

##
## run the DWH
##
docker run --name dwh -h dwh-host -d --link docker-lb --link mysql --link sphinx --link kaltura-nfs --privileged roiebeck/server-cluster-container-install-dwh

##
## configure the DWH
##
docker exec -it dwh /root/install/dwh_settings.sh