#!/bin/sh

# v1.0, 20/11/2014
# This script rsyncs a local EPEL mirror for Centos 7
# created by Yevgeniy Goncharov aka xck, Email - g.yevgeniy.p@gmail.com, Site - http://sys-admin.kz

# Vatiables
mirror="mirror.neolabs.kz/centos"
repobase="/mnt/repodata/centos"
rsync="/usr/bin/rsync -avrt --numeric-ids --delete --delete-after --delay-updates"
# version="7.2.1511 7 6.7"
version="7"
#baselist="os updates addons extras centosplus"
baselist="os updates addons extras"
# updaterepo="/usr/bin/createrepo --update"

# Update procedure
for ver in $version 
do 
  for base in baselist
  do 
    remote=$mirror/$ver/

    $rsync rsync://$remote $repobase/$ver --exclude=isos/
    # $updaterepo $repobase/$ver

  done
done

