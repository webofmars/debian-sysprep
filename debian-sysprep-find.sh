#!/bin/bash

CURRNAME=$(cat /etc/hostname)
CURRIP4=$(ip add sh dev eth0 | grep 'inet ' | awk '{ print $2; }' | cut -f 1 -d '/')
CURRIP6=$(ip add sh dev eth0 | grep 'inet6' | awk '{ print $2; }' | cut -f 1 -d '/')
CURRMAC=$(ip add sh dev eth0 | grep 'link/ether' | awk '{ print $2; }' | cut -f 1 -d '/')

echo "# files with name to be changed ($CURRNAME) :"
grep -rnisl $CURRNAME /etc

echo "# files with ipv4 ($CURRIP4):"
grep -rnisl $CURRIP4 /etc
grep -rnisl $CURRIP4 /var/lib
grep -rnisl $CURRIP4 /var/run

echo "# files with ipv6 ($CURRIP6):"
grep -rnisl $CURRIP6 /etc
grep -rnisl $CURRIP6 /var/lib
grep -rnisl $CURRIP6 /var/run

echo "# files with MAC addr ($CURRMAC):"
grep -rnisl $CURRMAC /etc
grep -rnisl $CURRMAC /var/run
