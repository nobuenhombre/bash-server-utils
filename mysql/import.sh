#!/bin/bash
source /home/SCRIPTS/config.cfg

for db in ${DBLIST[@]}
do
	if [-f "$DIR_UPLOAD_DB/$db.zip"];
	then
		cd $DIR_UPLOAD_DB
		unzip $db.zip
		rm "$DIR_UPLOAD_DB/$db.zip"
	fi
	if [-f "$DIR_UPLOAD_DB/$db.sql"];
	then
		mysql --user=$MYSQL_USER --password="$MYSQL_PASS" $db < $DIR_UPLOAD_DB/$db.sql
		rm "$DIR_UPLOAD_DB/$db.sql"
	fi
done
