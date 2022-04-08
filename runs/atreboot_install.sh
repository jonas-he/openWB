#!/bin/bash

# check for needed packages
echo "packages 1..."
if python -c "import evdev" &> /dev/null; then
	echo 'evdev installed...'
else
	sudo pip install evdev
fi
if ! [ -x "$(command -v sshpass)" ];then
	sudo apt-get -qq update
	sleep 1
	sudo apt-get -qq install sshpass
fi
if [ $(dpkg-query -W -f='${Status}' php-gd 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	sudo apt-get -qq update
	sleep 1
	sudo apt-get -qq install -y php-gd
	sleep 1
	sudo apt-get -qq install -y php7.0-xml
fi
# required package for soc_vwid
if [ $(dpkg-query -W -f='${Status}' libxslt1-dev 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
	sudo apt-get -qq update
	sleep 1
	sudo apt-get -qq install -y libxslt1-dev
fi

if [ ! -f /home/pi/ssl_patched ]; then
	sudo apt-get update
	sudo apt-get -qq install -y openssl libcurl3 curl libgcrypt20 libgnutls30 libssl1.1 libcurl3-gnutls libssl1.0.2 php7.0-cli php7.0-gd php7.0-opcache php7.0 php7.0-common php7.0-json php7.0-readline php7.0-xml php7.0-curl libapache2-mod-php7.0
	touch /home/pi/ssl_patched
fi

# check for mosquitto packages
echo "mosquitto..."
if [ ! -f /etc/mosquitto/mosquitto.conf ]; then
	sudo apt-get update
	sudo apt-get -qq install -y mosquitto mosquitto-clients
fi

# check for other dependencies
echo "packages 2..."
if python3 -c "import paho.mqtt.publish as publish" &> /dev/null; then
	echo 'mqtt installed...'
else
	sudo apt-get -qq install -y python3-pip
	sudo pip3 install paho-mqtt
fi
if python3 -c "import docopt" &> /dev/null; then
	echo 'docopt installed...'
else
	sudo pip3 install docopt
fi
if python3 -c "import certifi" &> /dev/null; then
	echo 'certifi installed...'
else
	sudo pip3 install certifi
fi
if python3 -c "import aiohttp" &> /dev/null; then
	echo 'aiohttp installed...'
else
	sudo pip3 install aiohttp
fi
if python3 -c "import pymodbus" &> /dev/null; then
	echo 'pymodbus installed...'
else
	sudo pip3 install pymodbus
fi
if python3 -c "import requests" &> /dev/null; then
	echo 'python requests installed...'
else
	sudo pip3 install requests
fi
#Prepare for jq in Python
if python3 -c "import jq" &> /dev/null; then
	echo 'jq installed...'
else
	sudo pip3 install jq
fi
#Prepare for ipparser in Python
if python3 -c "import ipparser" &> /dev/null; then
	echo 'ipparser installed...'
else
	sudo pip3 install ipparser
fi
#Prepare for lxml used in soc module libvwid in Python
if python3 -c "import lxml" &> /dev/null; then
	echo 'lxml installed...'
else
	sudo pip3 install lxml
fi

# update outdated urllib3 for Tesla Powerwall
pip3 install --upgrade urllib3