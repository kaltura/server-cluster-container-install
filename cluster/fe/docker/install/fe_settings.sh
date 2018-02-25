#!/bin/bash 
#===============================================================================
#          FILE: fe_settings.sh
#         USAGE: ./fe_settings.sh
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
## installed file exist
##
if [ -e /root/install/installed.ans ]; then
	echo "Install File exist this indicates that installation already accured on this machine, please remove"
	echo "installed.ans File and re-run the script"
	exit 2
fi

##
## config file must exist in all components
##
if [ -w /root/install/default.config.ans ] && [ $# -eq 0 ]; then
	dos2unix /root/install/default.config.ans
	. /root/install/default.config.ans #read the config.ans file into variables
elif [ $# -eq 0 ]; then
	echo No Answer File provided and /root/install/default.config.ans does not exist, nothing will be installed
	exit 1
else #load parameters from provided config file
	. $1
fi

##
##  installation is done if exist
##
if ! [ -e /root/install/installed.ans ]; then
	##
	## the FE api needs to be local
	##
	echo "127.0.0.1       " $CDN_HOST  >> /etc/hosts
	yum install -y kaltura-front kaltura-widgets kaltura-html5lib kaltura-html5-studio kaltura-clipapp rsync
	##
	## Bug in NFS  https://forum.kaltura.org/t/nfs-mount-centos7/6901/3
	##
	mkdir -p /tmp/opt/kaltura/web
	rsync -a /opt/kaltura/web /tmp/opt/kaltura/web

	echo "running /opt/kaltura/bin/kaltura-nfs-client-config.sh" $NFS_NAME $NFS_DOMAIN_NAME $NFS_USER $NFS_GROUP
	/opt/kaltura/bin/kaltura-nfs-client-config.sh $NFS_NAME $NFS_DOMAIN_NAME $NFS_USER $NFS_GROUP
	echo "done configuring nfs"

	##
	## now re-sync with mount nfs
	##
	rsync -a /tmp/opt/kaltura/web /opt/kaltura/web
	rm -rf /tmp/opt/kaltura/web

	if [ $# -eq 0 ]; then
		/opt/kaltura/bin/kaltura-front-config.sh /root/install/default.config.ans
	else
		/opt/kaltura/bin/kaltura-front-config.sh $1
	fi
	. /etc/kaltura.d/system.ini
	touch /root/install/installed.ans
	echo "installed" >> /root/install/installed.ans
fi

