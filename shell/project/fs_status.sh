#!/bin/bash

#monitoring free fs space disk

FS=$(df -H | egrep -v "Filesystem|tmpfs" | grep "/dev/root" | awk '{print $5}' | tr -d %)
if [[ $FS -gt 20 ]]
then
	echo "Warning, free space is low"
else
	echo "All Good"
fi
