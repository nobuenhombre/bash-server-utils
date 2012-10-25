#!/bin/bash
source /home/SCRIPTS/config.cfg

for db in ${DBLIST[@]}
do
	if [-f "$DIRDBRESTORE/$db.zip"];
	then
		cd $DIRDBRESTORE
		unzip $db.zip
		rm "$DIRDBRESTORE/$db.zip"
	fi
	if [-f "$DIRDBRESTORE/$db.sql"];
	then
		mysql --user=$MYSQLUSER --password="$MYSQLPASS" $db < $DIRDBRESTORE/$db.sql
		rm "$DIRDBRESTORE/$db.sql"
	fi	
done
