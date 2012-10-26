#!/bin/bash
source /home/SCRIPTS/config.cfg

LOG="$DIR_LOGS/delete-old-backups.txt"
rm $LOG

curyear=$(date +"%Y");
curmonth=$(date +"%m");
curday=$(date +%d);

for dir in `ls -F1 $DIR_BACKUPS_DB/ | grep -e ./ | tr -d \/`
do 
    diryear=$(echo $dir |awk 'BEGIN {FS="-"} {print $1}'); 
    dirmonth=$(echo $dir |awk 'BEGIN {FS="-"} {print $2}'); 
    dirday=$(echo $dir |awk 'BEGIN {FS="-"} {print $3}'); 
    
    if [ $curyear == $diryear ]; then
	if [ $dirday == "01" ]; then
    	    echo "Save first day of month dir - "$dir >> $LOG;
	else
	    if [ $dirmonth == $curmonth ]; then
    		echo "Save all days of current month dir - "$dir >> $LOG;
	    else
    		echo "Delete old dir - "$dir >> $LOG;
    		rm -r $DIR_BACKUPS_DB/$dir;
	    fi
	fi
    else
	echo "Delete old year dir - "$dir >> $LOG;
    	rm -r $DIR_BACKUPS_DB/$dir;
    fi
    
done

echo " " >> $LOG
echo " " >> $LOG

echo "Hard Drive Info" >> $LOG
echo "===========================" >> $LOG
df -h >> $LOG
echo "===========================" >> $LOG

mail -s "Delete old Mysql backups + Free space report" $EMAIL < $LOG