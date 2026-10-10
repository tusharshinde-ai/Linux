#!/bin/bash

declare -A myarray

myarray=( [name]=Tushar [Phone No.]=8698755422 ) 

echo "my name is ${myarray[name]}"
echo "my phone no. is ${myarray[Phone No.]}"
