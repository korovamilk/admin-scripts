#!/bin/bash
# IP address change logger and notifier
# v.201303211157
# http://korovamilky.tumblr.com
 
LOGGER="${HOME}/ip_change.log"
TMP_NOTIFY="/tmp/ip_notify.log"
HOST=$(hostname)
ADMIN_MAIL="admin@example.com"     ####  ####  ####  <- CHANGE THIS ####
IP=$(curl -s icanhazip.com)
TIMESTAMP=$(date "+%Y%m%d %H:%M")
 
touch $TMP_NOTIFY
 
if [ ! -f $LOGGER ];
then
        touch $LOGGER
        echo "         host: $HOST" > $LOGGER
fi
 
echo " host: $HOST" | tee -a $TMP_NOTIFY
echo " discovered ip: $IP" | tee -a $LOGGER $TMP_NOTIFY
echo " timestamp: $TIMESTAMP" | tee -a $LOGGER $TMP_NOTIFY
echo | tee -a $LOGGER $TMP_NOTIFY
mutt -s "$HOST - ip change detected" $ADMIN_MAIL < $TMP_NOTIFY
rm -f $TMP_NOTIFY
exit 0
