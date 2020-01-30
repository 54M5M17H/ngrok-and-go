#!/bin/bash
source /opt/ngrok/url_update.conf

# let ngrok get running
sleep 30

URL=$(curl http://localhost:4040/api/tunnels/ | jq .tunnels[0].public_url)
echo "Got url $URL"

REQ=$(printf '{"personalizations": [{"to": [{"email": "%s"}]}],"from": {"email": "ngrok_url_update@acer-ube.com"},"subject": "Ngrok URL on Acer Ubuntu has changed","content": [{"type": "text/plain", "value": %s}]}' $NGROK_UPDATE_EMAIL $URL)

curl --request POST \
  --url https://api.sendgrid.com/v3/mail/send \
  --header "Authorization: Bearer $SENDGRID_API_KEY" \
  --header 'Content-Type: application/json' \
  --data "$REQ"

