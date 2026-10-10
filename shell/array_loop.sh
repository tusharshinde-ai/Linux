#!/bin/bash

servers=(web01 web02 db01 db02)

for server in "${servers[@]}"
do
	echo "server:$server"
done
