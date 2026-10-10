#!/bin/bash

read -p "Which site do you want to check? " site

if ping -c 1 "$site" > /dev/null 2>&1
then
    echo "Successfully connected to $site"
else
    echo "Unable to connect to $site"
fi
