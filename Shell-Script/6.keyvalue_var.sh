#!/bin/bash

# how to store the key value pair

declare -A myArray

myArray=( [name]=Tushar [age]=29 [place]=Mumbai )

echo "My name is ${myArray[name]}"

echo "My Birth Place is ${myArray[place]}"
