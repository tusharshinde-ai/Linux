#!/bin/bash

read -p "Enter your Email ID" EMAIL

# mail subject = Postfix Gmail Test
# mail body =  This email is relayed through Gmail!

echo "This email is relayed through Gmail!" | mail -s "Postfix Gmail Test" $EMAIL
