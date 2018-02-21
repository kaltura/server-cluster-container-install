#!/usr/bin/env bash
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

docker run -d --storage-opt size=120G --net=bridge --privileged --name kalt-nfs -h kalt-nfs roiebeck/nfs:latest

