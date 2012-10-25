#!/bin/bash
source /home/SCRIPTS/config.cfg

LOGNAME="$DIRLOGS/clear-logs.txt"
rm $LOGNAME

service httpd stop
service mysqld stop

for web in ${WEBDIRS[@]}
do
    echo "----[ Clear log for $web ]----"
    rm "/home/sites/$web/logs/error.log.txt"
done

service mysqld start
service httpd start

echo "Logs clear. HTTPD + MySQL restarted." >> $LOGNAME;
mail -s "Clear logs report" EMAIL < $LOGNAME