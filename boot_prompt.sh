#!/bin/bash
# Filename: boot_prompt.sh
# Description: 	Shows connected interface(s) at boot and related ip address(es) on tty login prompt
#				Useful for datacenter unlabeled machines or VMware Virtual Machines without vmtools package.
# Usage: Put it somewhere (ie. /etc/init.d/) and then add its full path entry to /etc/rc.d/rc.local
#
# Author: marco[dot]agate@gmail[dot]com
# Version: 201304051644

DSTFILE="/etc/issue"
KEEPLINE=$(head -n 1 ${DSTFILE})
IFACE_UP=$(/sbin/ifconfig | grep 'Bcast:' -B1 | grep -v inet | grep -v - -- | awk '{print $1}')

echo ${KEEPLINE} | sed 's/\\\\/\\/g' > ${DSTFILE}
echo >> $DSTFILE

if [ -z "$IFACE_UP" ]; then
        echo "\n No active connection found." >> $DSTFILE
else
        echo "Currently connected via:">> $DSTFILE
        for IFACE in $IFACE_UP;
        do IPADDR=$(/sbin/ifconfig $IFACE | grep 'Bcast:' | cut -d: -f2 | awk '{ print $1}')
                        echo " $IFACE $IPADDR" >> $DSTFILE
        done
fi

echo >> $DSTFILE

exit 0