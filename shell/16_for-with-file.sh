#!/bin/bash

FILE="/home/ubuntu/shell/names.txt"

for name in $(cat $FILE)
do
	echo "name is $name"
done


