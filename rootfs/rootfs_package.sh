#!/bin/sh
# Create a package of rootfs folder

 PWD=`pwd`
 RELEASE_NAME=rootfs_pkg
 VERSION=`date +%Y-%m-%d`
 TAR_OPT="--owner root --group root"
 FL_EX=""
 FILE_EXCLUDE="*.tbz2 rootfs_package.sh usr udhcpc.sh inittab fstab"
 
 
 for f in $FILE_EXCLUDE  
 do
    FL_EX="$FL_EX --exclude $f"
 done

 find $PWD -maxdepth 10 -name "*~" | xargs rm -f 
 rm -f $RELEASE_NAME* 
 tar -c $FL_EX $TAR_OPT -C $PWD . | bzip2 > $RELEASE_NAME-$VERSION.tbz2 && \
 echo "$RELEASE_NAME-$VERSION" is ready