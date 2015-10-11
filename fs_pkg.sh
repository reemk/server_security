#!/bin/sh

# Create a package of server_security folder

PWD=`pwd`
DATE=$(date +%Y-%m-%d)

FOLDER_MEDIA=server-sec-pkg
ROOTFS_FOLDER="$PWD/rootfs"
TOOLS_FOLDER="$PWD/tools"
SSH_FOLDER="$TOOLS_FOLDER/ssh-tool"
SSL_FOLDER="$TOOLS_FOLDER/ssl-tool"
ZLIB_FOLDER="$TOOLS_FOLDER/zlib-tool"

FOLDERS="$ROOTFS_FOLDER"

if [ $# -lt 1 ]; then
    echo "Usage : ./fs_pkg.sh FOLDER_NAME"
    exit 1
fi

if [ ! -d $1/$FOLDER_MEDIA ]; then
    mkdir -p $1/$FOLDER_MEDIA
fi

for d in $FOLDERS 
do
    cp $d/*-$DATE.tbz2 $1/$FOLDER_MEDIA
done