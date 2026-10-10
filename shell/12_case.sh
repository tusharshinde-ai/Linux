#!/bin/bash

echo "available options"
echo "A for print date"
echo "B for list of scripts"
echo "C to check current location"

read -p "Input your choise: " choise
case $choise in
	A) date;;
	B) ls;;
	C) pwd;;
	*) echo "Please provide valid value"
esac


	
