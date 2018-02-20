#!/bin/bash 
#===============================================================================
#          FILE: nfs-settings.sh
#         USAGE: ./nfs-settings.sh 
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

EXPORTS=/etc/exports
IDMPAD=/etc/idmapd.conf


if ! [ -w $EXPORTS ];then
	echo "/etc/exports is not editable"
	exit 1
elif ! [ -w $IDMPAD ];then
 	echo "/etc/idmapd.conf is not editable"
	exit 1
fi

cp $EXPORTS $EXPORTS.orig
cp $IDMPAD $IDMPAD.orig
echo "/opt/kaltura/web/ *(rw,sync,no_subtree_check,no_root_squash)" >> /etc/exports
sed -i 's@^\[General\]$@[General]\nDomain = kaltura.dev\n@' $IDMPAD
#sed -i 's@^\[Mapping\]$@[Mapping]\nNobody-User = nobody\n@' $IDMPAD
#sed -i 's@^\[Mapping\]$@[Mapping]\nNobody-Group = nobody\n@' $IDMPAD

groupadd -r kaltura -g7373 
useradd -M -r -u7373 -d /opt/kaltura -s /bin/bash -c "Kaltura server" -g kaltura kaltura 
groupadd -g 48 -r apache 
useradd -r -u 48 -g apache -s /sbin/nologin -d /var/www -c "Apache" apache 
usermod -a -G kaltura apache 
chown -R kaltura.apache /opt/kaltura/web 
chmod 775 /opt/kaltura/web 
exportfs -a


echo "Going To Run rpc.mountd in foreground"


