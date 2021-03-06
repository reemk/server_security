#!/bin/bash

 WLAN0_IP="192.168.0.10"
 ETH0_IP="192.168.0.16"
 ADDR_IP="$ETH0_IP $WLAN0_IP"

 SMB_FOLDER_PC="Documents"
 SMB_FOLDER_HDD="Passport"
 SMB_FOLDER="$SMB_FOLDER_PC"

 SMB_MNT=/home/reeeemk/server_security/mnt
 SMB_PASSWD=/home/reeeemk/server_security/rootfs/smb_passwd

 SERVER_FOLDER=/mnt/udisk
 SERVER_USER=souleymane_imrane
 SERVER_HOST=serversec
 
 SMB_CMD=/usr/bin/smbmount
 SMB_CMD_OPT="-o credentials=$SMB_PASSWD"

 RSYNC_CMD=/usr/bin/rsync
 FOLDER_HDD_EXCLUDE="--exclude homepc --exclude $RECYCLE.BIN --exclude Thumbs.db --exclude ETUDE_CONVERGENCE --exclude poky-overkiz --exclude CVS --exclude wearing_solde --exclude debian_x86.rar --exclude homepc/Mes_documents --exclude RASPI_PROJECT"
 FOLDER_PC_EXCLUDE="--exclude=debian_x86 --exclude=debina_8.7"

 RSYNC_DEBUG_FILE="/dev/shm/rsync_debug"
 RSYNC_DEBUG="--log-file=$RSYNC_DEBUG_FILE"
 RSYNC_CMD_OPT="-vrlt $RSYNC_DEBUG $FOLDER_PC_EXCLUDE"

 [ -x $SMB_CMD ] && [ -x $RSYNC_CMD ] || exit 1

 trap clean 0 1 2 3 4

 clean () {
     sudo umount -f $SMB_MNT 2> /dev/null
 }

 rv=1

 for ip in $ADDR_IP 
 do
     sudo $SMB_CMD //$ip/$SMB_FOLDER $SMB_MNT $SMB_CMD_OPT > /dev/null

     if [ $? -ne 0 ]; then
	 logger "$0 failed for $ip to mount $SMB_FOLDER"
     else
	 rm -f $RSYNC_DEBUG_FILE
	 $RSYNC_CMD $RSYNC_CMD_OPT $SMB_MNT/  $SERVER_USER@$SERVER_HOST:$SERVER_FOLDER
	 if [ $? -ne 0 ]; then
	     logger "$0 failed for $ip to rsync $SMB_MNT folder"
	 else
	     logger "$0 finished to rsync all folders"
	     rv=0
	 fi
     fi

 done 

 exit $rv