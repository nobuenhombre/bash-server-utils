#!/bin/sh
SERVICES=("mysqld" "httpd")
ACTIONS=("stop" "start")
for action in ${ACTIONS[@]}
do
	for service in ${SERVICES[@]}
	do
		service $service $action
	done
done