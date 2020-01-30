# NGROK & Go

My ISP uses CGNAT, so my network does not have a public IP, preventing me from port forwarding to local machines.

So should I do if I have a local box I want to SSH into remotely? The answer is NGROK.

With ngrok though, unless you have a paid account, everytime it restarts you get a new subdomain. If my local machine rebooted I'd have no way of knowing this new URL.

I put this repo together to solve that problem. Every time ngrok is restarted by systemd it will email you the new URL, so you always know how to connect.

## Requirements
Ngrok needs to be installed. You also need systemd to be running.

You'll need a Sendgrid api key. You can get one for free at sendgrid.com.
An Ngrok token is also required. Again this is free at ngrok.com.

## Get Started
This has been tested on Ubuntu & should work on any Linux OS.

To get setup, run `install.sh` as root:

```
chmod +x ./install.sh
sudo ./install.sh
```

## Debugging
Used `journalct -xe` to check that everything runs. Please open an issue with any errors.

