#!/bin/bash

read -p "enter your marks: " marks

if [[ $marks -gt 40 ]]
then 
	echo "you are passed"
else
	echo "you are failed"
fi
