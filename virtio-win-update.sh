#!/bin/bash
# Script for clone virtio-win repository from https://fedorapeople.org/groups/virt/virtio-win/repo/stable
# Created by Yevgeniy Goncharov, http://sys-adm.in

# ---------------------------------------------------------- VARIABLES #
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

REPOLINK="fedorapeople.org/groups/virt/virtio-win/repo/stable/"
HTTP="https://"
REPOFOLDER="/mnt/repodata/virtio-win/"

rsync -av rsync://$REPOLINK $REPOFOLDER

# Clear links and grep rpm
LINKS=(`wget -O - $HTTP$REPOLINK | grep -o '<a href=['"'"'"][^"'"'"']*['"'"'"]' | sed -e 's/^<a href=["'"'"']//' -e 's/["'"'"']$//' | grep -E 'virtio-win.*rpm'`)

# echo ${LINKS[*]}

for i in ${LINKS[@]}; do
	# echo "wget  $HTTP$REPOLINK$i -O -P $REPOFOLDER$i"
	rm -rf $REPOFOLDER$i
	wget  $HTTP$REPOLINK$i -O $REPOFOLDER$i
done

