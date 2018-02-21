#!/bin/bash 
#===============================================================================
#          FILE: fe_db_settings.sh
#         USAGE: ./fe_db_settings.sh
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
if [ -w /root/install/default.config.ans ] && [ $# -eq 0 ]; then
	dos2unix /root/install/default.config.ans
	. /root/install/default.config.ans #read the config.ans file into variables
elif [ $# -eq 0 ]; then
	echo No Answer File provided and /root/install/default.config.ans does not exist, nothing will be installed
	exit 1
else
    . $1
fi

##
##  if no  db.ans file exist then full install else only partial install
##
if ! [ -e /root/install/db.ans ]; then
	echo "installing /opt/kaltura/bin/kaltura-db-config.sh" $DB1_HOST $SUPER_USER $SUPER_USER_PASSWD $DB1_PORT $SPHINX_HOST
	/opt/kaltura/bin/kaltura-db-config.sh $DB1_HOST $SUPER_USER $SUPER_USER_PASSWD $DB1_PORT $SPHINX_HOST
	touch /root/install/db.ans
	echo "db installed" >> /root/install/db.ans
else
	echo "upgrading /opt/kaltura/bin/kaltura-db-config.sh" $DB1_HOST $SUPER_USER $SUPER_USER_PASSWD $DB1_PORT $SPHINX_HOST
	/opt/kaltura/bin/kaltura-db-config.sh $DB1_HOST $SUPER_USER $SUPER_USER_PASSWD $DB1_PORT upgrade
	echo "db upgraded" >> /root/install/db.ans
fi

