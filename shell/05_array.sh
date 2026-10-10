#!/bin/bash


# array

MyArray=(1 20 30.5 Hello "Hey Buddy!")
#servers=(web01 web02 db01 db02)
echo "Value in 3rd index ${MyArray[3]}"

echo "all value from index ${MyArray[*]}"

#echo "value from index 2-3 ${Mweb01 web02 db01 db

<< 'comment'
echo "${servers[0]}"
echo "${servers[2]}"
echo "${servers[@]}"
echo "${#servers[@]}"
echo "${servers[0]}"
echo "${servers[-1]}"
comment

MyArray+=(100 200 300)
echo "value of all array in the index ${MyArray[*]}"
