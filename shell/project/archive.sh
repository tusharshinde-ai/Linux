#!/bin/bash

#Revision:001$
#Date:Sun Oct 18 16:25:53 UTC 2026

#Variables
BASE=/home/ubuntu/Linux/shell/project
DAYS=10
DEPTH=1
RUN=0

#Check if directory present or not
if [ ! -d $BASE ]
then
	echo "directory does not exist: $BASE"
	exit 1
fi

#Create archive folder if not present
if [[ ! -d $BASE/archive ]]
then
	mkdir $BASE/archive
fi

#find the list of files largest than 1MB
for i in $(find "$BASE" -maxdepth "$DEPTH" -type f -size +1M)
do
	if [ $RUN -eq 0 ]
	then 
		echo "[$(date "+%Y-%m-%d %H:%M:%S")] archiving $i ==> $BASE/archive"
		gzip "$i" || exit 1
		mv $i.gz $BASE/archive || exit 1
	fi
done


