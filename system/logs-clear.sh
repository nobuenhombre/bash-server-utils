#!/bin/bash
source /home/SCRIPTS/config.cfg

LOG="$DIR_LOGS/clear-logs.txt"
rm $LOG

service httpd stop
service mysqld stop

for web in ${WEBDIRS[@]}
do
    echo "----[ Clear log for $web ]----"
    rm "/home/sites/$web/logs/error.log.txt"
done

service mysqld start
service httpd start

echo "Logs clear. HTTPD + MySQL restarted." >> $LOG;
mail -s "Clear logs report" $EMAIL < $LOG