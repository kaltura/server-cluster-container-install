##
##Dockerfile base is Nginx
##
FROM nginx

RUN rm /etc/nginx/conf.d/default.conf

##
## copy configuration of my.cnf
##
COPY ./docker/install/* /root/install/
RUN chmod -R 755 /root/install/
COPY ./docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf
RUN chmod -R 755 /etc/nginx/conf.d/default.conf


EXPOSE 80 443 1935 88 8443

##CMD ["nginx", "-g", "daemon off;"]