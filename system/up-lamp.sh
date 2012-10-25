#!/bin/sh
SERVICES=("mysqld" "httpd")
for service in ${SERVICES[@]}
do
    if ps ax | grep -v grep | grep $service > /dev/null
    then
        echo "$service service running, everything is fine"
    else
        echo "$service is not running, starting..."
        service $service start
    fi
done
