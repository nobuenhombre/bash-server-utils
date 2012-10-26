#!/bin/bash
source /home/SCRIPTS/config.cfg

DB_NAME="dbname1";
DB_USER_NAME="dbusername1";
DB_USER_PASS="dbuserpass1";

mysql --user=$MYSQL_USER --password="$MYSQL_PASS" << eof
USE mysql;
CREATE USER '$DB_USER_NAME'@'localhost' IDENTIFIED BY '$DB_USER_PASS';
GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON $DB_NAME.* TO '$DB_USER_NAME'@'localhost';
eof
