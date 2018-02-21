#!/bin/bash 
#===============================================================================
#          FILE: dwh_settings.sh
#         USAGE: ./dwh_settings.sh
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
	echo "running /opt/kaltura/bin/kaltura-nfs-client-config.sh" $NFS_NAME $NFS_DOMAIN_NAME $NFS_USER $NFS_GROUP
	/opt/kaltura/bin/kaltura-nfs-client-config.sh $NFS_NAME $NFS_DOMAIN_NAME $NFS_USER $NFS_GROUP
	echo "done configuring nfs"
	if [ $# -eq 0 ]; then
	  /opt/kaltura/bin/kaltura-dwh-config.sh /root/install/default.config.ans
	else
        /opt/kaltura/bin/kaltura-dwh-config.sh $1
	fi
	touch /root/install/installed.ans
	echo "installed" >> /root/install/installed.ans
fi

