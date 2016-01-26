#!/bin/bash

CURRNAME=$(cat /etc/hostname)
NEWNAME=$1

# functions
usage() {
    echo "usage : $0 <new hostname>"
    exit 1
}

# main
[ "$1" ] || usage
BACKDIR="$HOME/backups/sysprep/$(date +%Y-%m-%d_%H-%M-%S)"
[ -d  $BACKDIR ] || mkdir -p $BACKDIR

for file in /etc/hosts /etc/hostname /etc/mailname /etc/exim4/update-exim4.conf.conf; do
    grep $CURRNAME $file > /dev/null 2>&1
    if [ $? ]; then
       echo "# changing names in file $file"
       cp $file $BACKDIR/
       sed -i -e "s/$CURRNAME/$NEWNAME/" $file
    fi
done

for file in /etc/ssh/ssh_host_*_key.pub  /etc/ssh/ssh_host_*_key /var/lib/dhcp/dhclient.*.leases; do
    echo "# removing generated file $file"
    cp $file $BACKDIR/
    rm $file
done

echo "# doing post-actions"
dpkg-reconfigure openssh-server

echo "# DONE. you should now REBOOT your machine."
