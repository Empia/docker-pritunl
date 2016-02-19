#!/bin/sh
set -e

[ -d /dev/net ] ||
    mkdir -p /dev/net
[ -c /dev/net/tun ] ||
    mknod /dev/net/tun c 10 200

/usr/bin/pritunl start --pidfile /data/run/pritunl.pid --conf /pritunl.conf