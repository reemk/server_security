#!/bin/sh

IFACE=eth0
DAEMON=/sbin/udhcpc
PIDDIR=/var/run
PIDFILE=$PIDDIR/udhcpc.pid
ARGS="--background --pidfile $PIDFILE --interface $IFACE --release --now --timeout 5 --tryagain 60"


 [ -x $DAEMON ] || exit 1

 if [ ! -d $PIDDIR ]; then
     mkdir -p $PIDDIR
 fi

 PIDDAEMON=`pidof $DAEMON`
 if [ -n "$PIDDAEMON" ] ; then
     kill -9 $PIDDAEMON
 fi

 $DAEMON $ARGS
   