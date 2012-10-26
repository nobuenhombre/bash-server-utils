#!/bin/bash
source /home/SCRIPTS/config.cfg

for db in ${DBLIST[@]}
do
    echo "----[ Repair :: $db ]----"
    mysqlcheck --auto-repair --user=$MYSQL_USER --password="$MYSQL_PASS" $db
done
