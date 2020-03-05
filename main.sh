#!/bin/bash
#
set -x
#

mv /etc/httpd/conf.d/application.conf /etc/httpd/conf.d/$APPLICATION.conf
sed -i "s/application/$APPLICATION/g" /etc/httpd/conf.d/$APPLICATION.conf

# Adjusts Laravel Permissions
chmod 775 -R /var/www/html/$APPLICATION/storage /var/www/html/$APPLICATION/bootstrap
chmod 775 /var/www/html/$APPLICATION/.env

# Starts Apache
/usr/sbin/httpd -DFOREGROUND