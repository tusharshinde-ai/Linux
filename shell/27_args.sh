#!/bin/bash

# To access the Arguments

set -x
#to access the arguments

if [[ $# -eq 0 ]]
then	
	echo "please provide atleast one Argument"
	exit 1
fi

echo "First argument $1"
echo "Second Argument $2"

echo "Total count of Arguments $#"
echo "All Arguments $@"

#For loop to access the value from arguements


