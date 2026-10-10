#!/bin/bash
#$Revision:001$
#$Sat Oct 10 14:15:11 UTC 2026

#Variable
BASE=/home/ubuntu/find_command
DAYS=10
DEPTH=1
RUN=0

#Check if Directory is present or not
if [[ ! -d $BASE ]]
then
	echo "Directory does not exist: $BASE"
	exit 1
fi

#Create archive folder is not present
if [[ ! -d $BASE/archive ]]
then
	mkdir -p $BASE/archive
fi

set -e

#Find the list of files larger than 20MB
while IFS= read -r -d '' i; 
do
	if 
		[[ "$i" == "$BASE/archive/"* ]];
	then
		continue
	fi
	
	if
		[[ "$RUN" -eq 0 ]]
	then
		echo "[(date '+%Y-%m-%d %H-%M-%S')] archiving $i ==> $BASE/archive"

		gzip -- "$i"
		mv "$i.gz" "$BASE/archive/"
	fi
done < <(find "$BASE" -maxdepth "$DEPTH" -type f -size +20M -print0 )


