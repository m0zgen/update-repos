#!/bin/bash

# v1.0, 20/11/2014
# This script rsyncs a local EPEL mirror for Centos 7
# created by Yevgeniy Goncharov aka xck, Email - g.yevgeniy.p@gmail.com, Site - http://sys-admin.kz

#Variables
DATE=`date +%Y%m%d%H%m`
LOG=/var/log/update-centos/update-epel-mirror-${DATE}.log
CURRENT_DIR=`pwd`

#Variables - mirror
LOCAL_MIRROR_BASE=/mnt/repodata/epel
LOCAL_MIRROR=${LOCAL_MIRROR_BASE}/
#
EPEL_MIRROR=mirror.aarnet.edu.au/pub/epel

#rsync -vaH --exclude=4/ --exclude=4AS/ --exclude=4ES/ --exclude=4WS/ --exclude=5/ --exclude=5Client/ --exclude=5Server/ --numeric-ids --delete --delete-after --delay-updates  rsync://mirror.aarnet.edu.au/pub/epel/ /data/updates/epel/

#Other mirrors:
#rsync://mirror.internode.on.net/fedora-enchilada
#rsync://mirror.aarnet.edu.au/fedora/linux
#rsync://download.fedora.redhat.com/fedora-enchilada
#http://mirrors.fedoraproject.org/publiclist/Fedora/12/
#http://rpmfusion.org/Mirrors

BASE_ARCH=x86_64

EXCLUDES="--exclude=4/ --exclude=4AS/ --exclude=4ES/ --exclude=4WS/ --exclude=5/ --exclude=5Client/ --exclude=5Server/ --exclude=6Server/ --exclude=testing/ --exclude=ppc/ --exclude=ppc64/ --exclude=SRPMS/ --exclude=x86_64/debug/ --exclude=i386/" 


if [ ! -d ${LOCAL_MIRROR} ]; then
	echo "Creating new mirror directory ${LOCAL_MIRROR} ..."
	mkdir -p ${LOCAL_MIRROR}
fi

# EPEL images repo
echo "attempting EPEL repo update from ${EPEL_MIRROR} to ${LOCAL_MIRROR} ..."
rsync -vaH ${EXCLUDES} --numeric-ids --delete --delete-after --delay-updates  rsync://${EPEL_MIRROR}/ ${LOCAL_MIRROR}
if [ $? -ne 0 ]
then
        echo "EPEL mirror update FAILED" >> ${LOG}
else
	echo "EPEL mirror update successful" >> ${LOG}
fi

/bin/cat ${LOG}

exit 0
