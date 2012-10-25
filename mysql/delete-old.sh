#!/bin/bash
source /home/SCRIPTS/config.cfg

curyear=$(date +"%Y");
curmonth=$(date +"%m");
curday=$(date +%d);

LOGNAME="$DIRLOGS/delete-old-backups.txt"
rm $LOGNAME

for dir in `ls -F1 $DIRBACKUPS/ | grep -e ./ | tr -d \/`
do 
    diryear=$(echo $dir |awk 'BEGIN {FS="-"} {print $1}'); 
    dirmonth=$(echo $dir |awk 'BEGIN {FS="-"} {print $2}'); 
    dirday=$(echo $dir |awk 'BEGIN {FS="-"} {print $3}'); 
    
    if [ $curyear == $diryear ]; then
	if [ $dirday == "01" ]; then
    	    echo "Save first day of month dir - "$dir >> $LOGNAME;
	else
	    if [ $dirmonth == $curmonth ]; then
    		echo "Save all days of current month dir - "$dir >> $LOGNAME;
	    else
    		echo "Delete old dir - "$dir >> $LOGNAME;
    		rm -r $DIRBACKUPS/$dir;
	    fi
	fi
    else
	echo "Delete old year dir - "$dir >> $LOGNAME;
    	rm -r $DIRBACKUPS/$dir;
    fi
    
done

echo " " >> $LOGNAME
echo " " >> $LOGNAME

echo "Hard Drive Info" >> $LOGNAME
echo "===========================" >> $LOGNAME
df -h >> $LOGNAME
echo "===========================" >> $LOGNAME

mail -s "Delete old Mysql backups + Free space report" $EMAIL < $LOGNAME