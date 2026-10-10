#!/bin/bash

myvars="Hey buddy! how are you"
myvarsLenght=${#myvars}

echo "Lenghth of array $myvarsLenght"
echo "Index in upper case seems like ${myvars^^}"
echo "Index in lower case seems like ${myvars,,}"

newvars=${myvars/buddy/tushar}

echo "change in variable $newvars"
echo "after slice ${myvars:4:-0}"
