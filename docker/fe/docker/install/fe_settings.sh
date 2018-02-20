#!/bin/bash 
#===============================================================================
#          FILE: mysql_run.sh
#         USAGE: ./mysql_run.sh 
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

# set SElinux enforcement to permissive
setenforce permissive

##
## config file must exist in all components
##

if [ -w /root/install/config.ans ] && [ ! -e /root/install/installed.ans ]; then
	dos2unix /root/install/config.ans
	. /root/install/config.ans #read the config.ans file into variables
else
	echo answer file must exist and be writeable
	exit 1
fi

##
## the FE api needs to be local
##
echo "127.0.0.1       " $CDN_HOST  >> /etc/hosts 

##
##  installation is done if exist
##
if ! [ -e /root/install/installed.ans ]; then
	echo 'running /opt/kaltura/bin/kaltura-nfs-client-config.sh $NFS_NAME $NFS_DOMAIN_NAME $NFS_USER $NFS_GROUP'
	/opt/kaltura/bin/kaltura-nfs-client-config.sh $NFS_NAME $NFS_DOMAIN_NAME $NFS_USER $NFS_GROUP
	echo done configuring nfs
	yum install -y kaltura-front kaltura-widgets kaltura-html5lib kaltura-html5-studio kaltura-clipapp
	/opt/kaltura/bin/kaltura-front-config.sh /root/install/config.ans
	. /etc/kaltura.d/system.ini
	touch /root/install/installed.ans
	echo "installed" >> /root/install/installed.ans
fi

