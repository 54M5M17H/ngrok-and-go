#!/bin/bash

# to kill any existing
# kill -9 $(ps -ef | grep 'ngrok' | grep -v 'grep' | grep -v 'vim' | awk '{print $2}')

URL=$(curl http://localhost:4040/api/tunnels/ | jq .tunnels[0].public_url)
echo "Got url $URL"

REQ=$(printf '{"personalizations": [{"to": [{"email": "%s"}]}],"from": {"email": "ngrok_url_update@acer-ube.com"},"subject": "Ngrok URL on Acer Ubuntu has changed","content": [{"type": "text/plain", "value": %s}]}' $TO_EMAIL $URL)

echo $REQ

curl --request POST \
  --url https://api.sendgrid.com/v3/mail/send \
  --header "Authorization: Bearer $SENDGRID_API_KEY" \
  --header 'Content-Type: application/json' \
  --data "$REQ"

