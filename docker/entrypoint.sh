#!/bin/bash

sudo service sudo start
sudo service cron start
sudo service mosquitto start
sudo service apache2 start
sudo /var/www/html/openWB/runs/atreboot.sh
tail -f /var/log/openWB.log