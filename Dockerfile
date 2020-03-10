FROM centos:7

ENV APPLICATION application

LABEL Maintainer="Maykon Facincani <facincani.maykon@gmail.com>"
LABEL Description="Apache 2.4 & PHP 7.3 based on CentOS Linux."

RUN curl 'https://setup.ius.io/' | sh 

RUN yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm 
RUN yum -y install epel-release yum-utils

RUN yum-config-manager --enable remi-php73

RUN yum -y install php sudo httpd httpd-tools mod_ssl openssl mod_security mod_security_crs
RUN yum install -y php php-devel php-gd php-mbstring php-mcrypt php-mysqlnd php-pear php-xml php-opcache

RUN yum install -y php-intl php-bcmath php-snmp php-pdo php-pgsql php-pecl-zip php-intl php-ldap

RUN yum -y clean all && rm -rf /var/cache/yum

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

ADD php.d /etc/php.d

ADD conf.d /etc/httpd/conf.d

RUN rm /etc/httpd/conf.d/welcome.conf
RUN rm /etc/httpd/conf.d/ssl.conf


ADD ssl /etc/apache2/ssl/

# Create Containr User
# user/user
RUN useradd -M -s /bin/sh -g users -G apache,wheel -p paaGxbNLNTCao user 

COPY main.sh /root/main.sh
RUN chmod 755 /root/main.sh

WORKDIR /var/www/html
EXPOSE 80/tcp 443/tcp
CMD ["/root/main.sh"]