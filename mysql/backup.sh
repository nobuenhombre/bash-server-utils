#!/bin/bash
source /home/SCRIPTS/config.cfg

START=$(date +%s)
MYDATE=$(date --iso-8601)
DIRLAST="/home/BACKUPS/DB/$MYDATE"

mkdir $DIRLAST
/home/SCRIPTS/mysql/repair.sh
for db in ${DBLIST[@]}
do
    mysqldump --user=$MYSQLUSER --password="$MYSQLPASS" $db > $DIRLAST/$db.sql
done
rm $DIRBACKUPS/backup-last.zip
7za a -tzip -mx5 $DIRBACKUPS/backup-last.zip $DIRLAST/*.sql
for db in ${DBLIST[@]}
do
    rm $DIRLAST/$db.sql
done
cp $DIRBACKUPS/backup-last.zip $DIRLAST/backup.zip
rm $DIRFTP/backup.zip
cp $DIRBACKUPS/backup-last.zip $DIRFTP/backup.zip
swapoff -a
swapon -a

END=$(date +%s)
DIFF=$(( $END - $START ))
DIFFHUMAN=$(date -u -d @"$DIFF" +'%Hhour %-Mmin %-Ssec')

echo "MySQL Backup complete by $DIFFHUMAN." > $DIRLOGS/mysql-backup-last.txt
mail -s "Mysql backup report" $EMAIL < $DIRLOGS/mysql-backup-last.txt