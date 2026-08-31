#!/bin/bash

myVar="Hey Buddy, How are you?"

#To replace a string

newVar=${myVar/Buddy/Tushar}

myVarLength=${#myVar}

echo "Length of my Var is $myVarLength"

echo "Upper case is ${myVar^^}"
echo "Lower case is ${myVar,,}"


echo "New variable is $newVar"

# To slice string

echo "After slice ${myVar:4:5}"
