#!/bin/bash

a=10

until [[ $a -le 0 ]]
do
	echo "value of a is $a"
	let a--
done
