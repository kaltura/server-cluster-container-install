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

if [ -w /root/install/config.ans ]; then
	dos2unix /root/install/config.ans
	. /root/install/config.ans #read the config.ans file into variables
else
	echo answer file must exist and be writeable
	exit 1
fi



##
##  if no  db.ans file exist then full install else only partial install
##
if ! [ -e /root/install/db.ans ]; then
	echo 'installing /opt/kaltura/bin/kaltura-db-config.sh $DB1_HOST $SUPER_USER $SUPER_USER_PASSWD $DB1_PORT $SPHINX_HOST'
	/opt/kaltura/bin/kaltura-db-config.sh $DB1_HOST $SUPER_USER $SUPER_USER_PASSWD $DB1_PORT $SPHINX_HOST
	touch /root/install/db.ans
	echo "installed" >> /root/install/db.ans
else 
	echo 'upgrading /opt/kaltura/bin/kaltura-db-config.sh $DB1_HOST $SUPER_USER $SUPER_USER_PASSWD $DB1_PORT $SPHINX_HOST'
	/opt/kaltura/bin/kaltura-db-config.sh $DB1_HOST $SUPER_USER $SUPER_USER_PASSWD $DB1_PORT [upgrade]
fi

