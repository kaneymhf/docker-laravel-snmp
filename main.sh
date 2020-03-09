#!/bin/bash
#
set -x
#

mv /etc/httpd/conf.d/application.conf /etc/httpd/conf.d/$APPLICATION.conf
sed -i "s/application/$APPLICATION/g" /etc/httpd/conf.d/$APPLICATION.conf

sudo chown -R user:apache /var/www/html/$APPLICATION

# Adjusts Laravel Permissions
# If not installed set 775 to all
if [ $IS_INSTALLED -eq 1 ];
then
    sudo find /var/www/html/$APPLICATION/ -type f -exec chmod 644 {} \; 
    sudo find /var/www/html/$APPLICATION/ -type d -exec chmod 775 {} \;

    sudo chgrp -R apache /var/www/html/$APPLICATION/storage /var/www/html/$APPLICATION/bootstrap/cache
    sudo chmod -R ug+rwx /var/www/html/$APPLICATION/storage /var/www/html/$APPLICATION/bootstrap/cache

    sudo chmod 775 /var/www/html/$APPLICATION/.env
else
    sudo find /var/www/html/$APPLICATION/ -exec chmod 775 {} \;
fi

su -c 'cd /var/www/html/$APPLICATION && php artisan config:clear'
su -c 'cd /var/www/html/$APPLICATION && composer dump-autoload'

# Starts Apache
/usr/sbin/httpd -DFOREGROUND