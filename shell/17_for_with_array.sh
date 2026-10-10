#!/bin/bash

myarray=( 1 2 3 Hello Hi)
myarrayLength=${#myarray[*]}

for (( i=0; i<$myarrayLength; i++ ))
do
	echo "value of array is ${myarray[$i]}"
done

