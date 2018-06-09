# ROBODOMO DOCKER SCRIPTS

This directory contains some handy shell scripts to start docker containers on
your home automation server.

For my server, I chose this barebones PC:
https://www.amazon.com/gp/product/B00VBNSO8U/ref=oh_aui_search_detailpage?ie=UTF8&psc=1

It cost about 2x what a Raspberry Pi with case and power supply and other needed
accessories.  I did add a 4G RAM stick and I had a 2.5" SSHD lying around and
used that.  I installed Ubuntu Server 18.04 on it, and docker, and run these scripts.

Compare this server to the Pi:
* Ethernet: GigE vs 100MBit E (PI)
* RAM: 4G vs 1G (PI)
* CPU: Quad Core Intel Celeron J1900 (up to 2.4GHz) vs Quad Core Broadcom BCM2837
* 2x USB 2 and 1x USB 3.0 vs only 4x USB 2.0

The Brix can run any flavor of Unix, well supported.  The Pi would run Raspbian.
Docker does run on the Pi.  So way more RAM, much faster CPU, fast USB 3.1 to
add external hard drives at much higher speed, gigE.

I run 11 docker containers for RoboDomo on the Brix, plus Mosca (MQTT Broker)
and the system is quite zippy, as seen on the browsers/mobile devices.

# Notes

1) I did not write the SmartThings <-> MQTT service - there was a perfectly
suitable one already done and even dockerized.  See start-smartthings.sh for
details.  It uses a config file in /opt/mqtt-bridge/ (will create it if not
found).  I give you an example config file in mqtt-bridge-config.yml.  Edit a
copy and copy your file to /opt/mqtt-bridge/.

2) In my setup, I use dnsmasq to dhcp assign static IPs to all my devices
(SmartThings Hub, TVs, AV Receivers, TiVos, iPads/android tablets/phones, 
Home Automation Server - EVERY device on my LAN or WiFi).  Docker, by default,
uses Google's public (free/open) DNS that doesn't know my local hostnames.  In
order for the containers to be able to lookup my hosts, I had to create/edit
/etc/docker/daemon.json.  I provide a copy of mine in etc-docker-daemon.json.
Edit a copy and copy it to /etc/docker/ OR edit the existing one, if you have
one.  You only need to do so if you have DNS set up similar to mine.

