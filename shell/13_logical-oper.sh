#!/bin/bash

#AND Operator

read -p "What is your age?: " age
read -p "your country: " country

#if [[ $age -ge 18 ]] && [[ $country == "India" ]] # (In AND "&&" Operator both condition should satisfied)
 
if [[ $age -ge 18 ]] || [[ $country == "India" ]] # (In OR "||" Operator any one condition should satisfied)

then
	echo "you can vote"
else 
	echo "you cant vote"
fi
