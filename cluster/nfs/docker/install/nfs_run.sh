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

rpcbind
rpc.statd
rpc.nfsd


echo "Going To Run rpc.mountd in foreground"

exec rpc.mountd --foreground
