#!/bin/bash - 
#===============================================================================
#          FILE: kaltura-mysql-settings.sh
#         USAGE: ./kaltura-mysql-settings.sh 
#   DESCRIPTION: 
#       OPTIONS: ---
# 	LICENSE: AGPLv3+
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Roie Beck (), <Roie.Beck@kaltura.com>
#  ORGANIZATION: Kaltura, inc.
#       CREATED: 02/14/18 12:48:32 EST
#      REVISION:  ---
#===============================================================================

#set -o nounset                              # Treat unset variables as an error

if [ -r /etc/my.cnf ];then
	MY_CNF=/etc/my.cnf
elif [ -r /etc/mysql/my.cnf ];then
	MY_CNF=/etc/mysql/my.cnf
elif [ -r /usr/share/mysql/my-medium.cnf ];then
 	cp /usr/share/mysql/my-medium.cnf /etc/my.cnf
 	MY_CNF=/etc/my.cnf	
else
	echo "I could not find your my.cnf file. Exiting."
	exit 1
fi
cp $MY_CNF $MY_CNF.orig
sed -i '/^lower_case_table_names = 1$/d' $MY_CNF
sed -i '/^open_files_limit.*$/d' $MY_CNF
sed -i '/^max_allowed_packet.*$/d' $MY_CNF
sed -i 's@^\[mysqld\]$@[mysqld]\nlower_case_table_names = 1\n@' $MY_CNF
sed -i 's@^\[mysqld\]$@[mysqld]\ninnodb_file_per_table\n@' $MY_CNF
sed -i 's@^\[mysqld\]$@[mysqld]\ninnodb_log_file_size=32M\n@' $MY_CNF
sed -i 's@^\[mysqld\]$@[mysqld]\nopen_files_limit = 20000\n@' $MY_CNF
sed -i 's@^\[mysqld\]$@[mysqld]\nmax_allowed_packet = 16M\n@' $MY_CNF
if [ -r /var/lib/mysql/ib_logfile0 ];then
	mv /var/lib/mysql/ib_logfile0 /var/lib/mysql/ib_logfile0.old
fi
if [ -r /var/lib/mysql/ib_logfile1 ];then
	mv /var/lib/mysql/ib_logfile1 /var/lib/mysql/ib_logfile1.old
fi

service mysqld restart

##
## install mysql  with root password and allow remote connections
##
echo "going to install mysql and start services"
mysql_secure_installation <<EOF

y
root
root
y
n
y
y
EOF
	
##
## Allow remote connections from other containers
##	
mysql -uroot -proot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;"
mysql -uroot -proot -e "FLUSH PRIVILEGES;";


service mysqld stop

