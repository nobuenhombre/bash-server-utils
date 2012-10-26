#!/bin/bash
source /home/SCRIPTS/config.cfg

LOG="$DIR_LOGS/mysql-backup-last.txt"
rm $LOG

START=$(date +%s)
MYDATE=$(date --iso-8601)
DIRLAST="/home/BACKUPS/DB/$MYDATE"

mkdir $DIRLAST
/home/SCRIPTS/mysql/repair.sh

for db in ${DBLIST[@]}
do
    mysqldump --user=$MYSQL_USER --password="$MYSQL_PASS" $db > $DIRLAST/$db.sql
done

rm $DIR_BACKUPS_DB/backup-last.zip
7za a -tzip -mx5 $DIR_BACKUPS_DB/backup-last.zip $DIRLAST/*.sql

for db in ${DBLIST[@]}
do
    rm $DIRLAST/$db.sql
done
cp $DIR_BACKUPS_DB/backup-last.zip $DIRLAST/backup.zip

END=$(date +%s)
DIFF=$(( $END - $START ))
DIFFHUMAN=$(date -u -d @"$DIFF" +'%Hhour %-Mmin %-Ssec')

echo "MySQL Backup complete by $DIFFHUMAN." > $LOG
mail -s "Mysql backup report" $EMAIL < $LOG