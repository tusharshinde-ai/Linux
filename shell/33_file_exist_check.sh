#!/bin/bash

<< comment
FILEPATH="/home/ubuntu/shell/test.csv"

if [[ -f $FILEPATH ]]
then 
	echo "file exist"
else
	echo "file does not exist"
	exit 1
fi

comment

FILEPATH="/home/ubuntu/shell/tushar.txt"

if [[ -f $FILEPATH ]]
then 
	echo "file exist"
else
	echo "creating file"
	touch $FILEPATH
	echo "file created successfully"
fi

