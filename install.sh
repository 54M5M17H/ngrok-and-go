#!/bin/bash

# install ngrok

if [ "$USER" != "root" ]; then
    echo "Must run as root user: sudo"
fi

# move service to systemd
mv ./ngrok.service /etc/systemd/system/ngrok.service

# move scripts to /usr/local/bin
chmod +x ./get_ngrok_url.sh
mv ./get_ngrok_url.sh /usr/local/bin

# ensure environment vars
printf "Enter Sendgrid api key: "
read sendgridKey

printf "Enter the email you'd like to be notified at: "
read toEmail

printf "Enter your ngrok token -- get one by creating a free account at https://dashboard.ngrok.com/:"
read ngrokToken

# generate config file
echo "
export NGROK_UPDATE_EMAIL=$toEmail
export SENDGRID_API_KEY=$sendgridKey
" > /opt/ngrok/url_update.conf

# setup systemd -- reload and enable
systemctl daemon-reload
systemctl enable ngrok.service

# add ngrok auth token
ngrok authtoken $ngrokToken

# start
systemctl start ngrok.service

