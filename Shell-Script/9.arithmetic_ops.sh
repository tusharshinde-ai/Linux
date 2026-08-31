#!/bin/bash

# Math Calculation

read -p "Enter value of x :" x
read -p "Enter value of y :" y

#x=10
#y=20

# Multiplication

let mul=$x*$y
echo "Multiplication of x and y is $mul"

# Addition

let add=$x+$y
echo "addition of x and y is $add"

echo "subtraction of x and y is $((x-y))"
