#!/bin/bash

# Script to show how to use variables.

a=10
readonly name="Tushar"
age=39
HOSTNAME=$(hostname)

echo "my name is $name & age is $age & working on $HOSTNAME"

name="akash"
