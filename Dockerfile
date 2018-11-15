FROM centos/php-56-centos7
LABEL maintainer="ogarces@althek.com"

#Instalar Apache
RUN yum -y install httpd
RUN service httpd restart

#Instalar MySQL
RUN yum update
RUN yum -y install mysql-server
RUN /sbin/chkconfig --levels 235 mysqld on
RUN service mysqld start
RUN mysqladmin -u root password '12345678'

#Instalar nano
RUN yum -y install nano

#Instal php-pear
RUN yum -y install php-pear

#Agregar lineas al httpd
RUN echo 'AddType application/x-httpd-php .php' >> /etc/httpd/conf/httpd.conf
RUN sed -i 's/DirectoryIndex index.html index.html.var/DirectoryIndex index.html index.html.var index.php/g' /etc/httpd/conf/httpd.conf
RUN sed -i 's/#ServerName www.example.com:80/ServerName localhost:80/g' /etc/httpd/conf/httpd.conf

RUN yum -y install php-mysqli

EXPOSE 80