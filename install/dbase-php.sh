#!/bin/bash
yum -y install php-pear
yum -y install php-devel
yum -y install gcc
pecl install dbase
cd /etc/php.d/
echo "extension=dbase.so" > dbase.ini
cd /etc/
echo "extension=dbase.so" >> php.ini
service httpd restart

