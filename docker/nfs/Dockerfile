##
##Dockerfile base is centos 6
##
FROM centos:6

ENV container=docker

RUN echo "NETWORKING=yes" > /etc/sysconfig/network

##
## copy configuration of my.cnf
##
COPY ./docker/install/* /root/install/
RUN chmod -R 755 /root/install/

##
## install nfs , ntp and vim 
##
RUN yum install -y ntp vim && \
	chkconfig ntpd on

RUN yum -y --setopt=tsflags=nodocs install nfs-utils && \
    mkdir -p /opt/kaltura/web && \
    yum clean all	
	
	
##VOLUME ["/opt/kaltura/web"]
	
EXPOSE 111/tcp 111/udp 2049/tcp 2049/udp

##
## configure nfs
##
RUN /root/install/nfs_settings.sh

##
## entry to bash(run nfs)
##
CMD ["/root/install/nfs_run.sh"]