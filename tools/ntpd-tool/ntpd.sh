#!/bin/sh


 DAEMON=/sbin/ntpd
 PIDDIR=/var/run
 PIDFILE=ntpd.pid
 DAEMON_OPTS="-p $PIDDIR/$PIDFILE"

 [ -x $DAEMON ] || exit 1

 if [ ! -d $PIDDIR ]; then
     mkdir -p $PIDDIR
 fi

 case "$1" in 
     
     start)
	 start-stop-daemon --start --quiet --oknodo --pidfile $PIDDIR/$PIDFILE --startas $DAEMON -- $DAEMON_OPTS
	 ;;

     stop)
	 start-stop-daemon --stop --quiet --oknodo --pidfile $PIDDIR/$PIDFILE
	 rm -f $PIDDIR/$PIDFILE
	 ;;

     *)
	 echo "Usage : ntpd.sh {start|stop}"
	 exit 2
	;;

 esac