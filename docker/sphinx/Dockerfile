##
##Dockerfile
##
FROM centos:6

RUN echo "NETWORKING=yes" > /etc/sysconfig/network

##
## copy configuration of my.cnf
##
COPY ./docker/install/* /root/install/
RUN chmod -R 755 /root/install/

##
## Kaltura isntall
##
RUN rpm -ihv http://installrepo.kaltura.org/releases/kaltura-release.noarch.rpm && \
	sed -i 's@installrepo.kaltura.org@installrepo.origin.kaltura.org@g' /etc/yum.repos.d/kaltura.repo && \
	sed -i 's@^tsflags=nodocs@#tsflags=nodocs@g' /etc/yum.conf && \
	yum install -y  kaltura-base kaltura-sphinx kaltura-postinst && \
	yum install -y vim dos2unix
		
EXPOSE 9312/tcp 9312/udp

# start services
CMD ["/sbin/init"]