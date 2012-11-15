#!/bin/bash
source /home/SCRIPTS/config.cfg

if [ -f "$DIR_UPLOAD/sapphire.zip" ];
then
	mv "$DIR_UPLOAD/sapphire.zip" $DIR_UPLOAD_SAPPHIRE
fi
if [ -f "$DIR_UPLOAD_SAPPHIRE/sapphire.zip" ];
then
	cd $DIR_UPLOAD_SAPPHIRE
	unzip sapphire.zip
	rm "$DIR_UPLOAD_SAPPHIRE/sapphire.zip"
	rm -r $DIR_SAPPHIRE/*;
	cp -a $DIR_UPLOAD_SAPPHIRE/* $DIR_SAPPHIRE
	rm -r $DIR_UPLOAD_SAPPHIRE/*
fi
