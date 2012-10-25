#!/bin/bash
source /home/SCRIPTS/config.cfg

for db in ${DBLIST[@]}
do
    echo "----[ Repair :: $db ]----"
    mysqlcheck --auto-repair --user=root --password='' $db
done
