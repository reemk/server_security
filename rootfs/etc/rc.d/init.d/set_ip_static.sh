#!/bin/sh
# Set Static Ip Configuration

source /etc/ip_static.conf
BROADCAST="broadcast $BROADCAST_V"
NETMASK="netmask $NETMASK_V"
GATEWAY="gw $BOX"


 [ -x /sbin/ifconfig ] && [ -x /sbin/route ] || exit 1

 /sbin/ifconfig $IFACE $ADDRESS $BROADCAST $NETMASK 
 /sbin/route add default $GATEWAY
 echo "nameserver $BOX" > /etc/resolv.conf
 

