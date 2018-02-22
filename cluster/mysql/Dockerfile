##
##Dockerfile
##
FROM centos:6

RUN echo "NETWORKING=yes" > /etc/sysconfig/network


# copy configuration of my.cnf
COPY ./docker/install/* /root/install/
RUN chmod -R 755 /root/install/

##
## install mysql and post and ntp
##
RUN rpm -ihv http://installrepo.kaltura.org/releases/kaltura-release.noarch.rpm && \
	sed -i 's@installrepo.kaltura.org@installrepo.origin.kaltura.org@g' /etc/yum.repos.d/kaltura.repo && \
	sed -i 's@^tsflags=nodocs@#tsflags=nodocs@g' /etc/yum.conf && \
	yum install -y mysql-server kaltura-postinst ntp vim dos2unix


EXPOSE 3306/tcp 3306/udp

##
## Run mysql configuration file
##
RUN dos2unix /root/install/mysql_settings.sh
RUN /root/install/mysql_settings.sh


RUN	chkconfig ntpd on && \
	chkconfig mysqld on && \
	service ntpd start && \
	service mysqld start 

	
	
	
CMD ["/sbin/init"]

