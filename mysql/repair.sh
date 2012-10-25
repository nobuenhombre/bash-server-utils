#!/bin/bash
source /home/SCRIPTS/config.cfg

for db in ${DBLIST[@]}
do
    echo "----[ Repair :: $db ]----"
    mysqlcheck --auto-repair --user=$MYSQLUSER --password=$MYSQLPASS $db
done
