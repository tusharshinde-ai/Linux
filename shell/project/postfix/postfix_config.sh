
#!/bin/bash

# Get Gmail credentials from user
read -p "Enter your Gmail address: " GMAIL
read -s -p "Enter your Google App Password: " APP_PASSWORD
echo

# Install required packages
sudo apt update
sudo apt install -y libsasl2-modules ca-certificates

# Save Gmail credentials
echo "[smtp.gmail.com]:587 $GMAIL:$APP_PASSWORD" | sudo tee /etc/postfix/sasl_passwd > /dev/null

# Secure credentials and create database
sudo chmod 600 /etc/postfix/sasl_passwd
sudo postmap /etc/postfix/sasl_passwd

# Configure Postfix to use Gmail
sudo postconf -e "relayhost = [smtp.gmail.com]:587"
sudo postconf -e "smtp_sasl_auth_enable = yes"
sudo postconf -e "smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd"
sudo postconf -e "smtp_sasl_security_options = noanonymous"
sudo postconf -e "smtp_tls_security_level = encrypt"
sudo postconf -e "inet_protocols = ipv4"

echo "relaysvr.tss.com Tushar Shinde" | sudo tee /etc/postfix/generic > /dev/null

# Restart Postfix
sudo systemctl restart postfix

echo "Postfix Gmail configuration completed!"



