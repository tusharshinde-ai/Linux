#!/bin/bash

#Array

myArray=( 1 20 30.5 Hello "my array" )

# Updating array with new value.

myArray+=( 50 pass)
# To get value of 3rd Index

echo "value in 3rd index ${myArray[3]}"


# To get all value of array

echo "all the value in Array ${myArray[*]}"

# To get length of array

echo "No. of values, length of an array is ${#myArray[*]}"

# To get value from mid Index

echo "value from Index 2-3 ${myArray[*]:1:2}"


