#!/bin/bash

NEW_HOSTNAME="relaysvr.tss.com"

sudo hostnamectl set-hostname $NEW_HOSTNAME
echo "hostname has been modified & new hostname is $NEW_HOSTNAME"

sudo apt update

echo "postfix postfix/main_mailer_type select Internet Site" | sudo debconf-set-selections
echo "postfix postfix/mailname string $NEW_HOSTNAME" | sudo debconf-set-selections

sudo apt install -y postfix mailutils

sudo postconf -e "myhostname = $NEW_HOSTNAME"

sudo systemctl enable --now postfix

echo "Postfix installation completed!"
sudo systemctl status postfix --no-pager

