#!/bin/bash

# constant variable
#
HOSTNAME=$(hostname)
a=10
readonly name="Tushar" # readonly makes variable constant. 
age=38

echo "My name is $name, my age is $age & I'm working on $HOSTNAME"

name="Bunty"

echo "my name is $name"

