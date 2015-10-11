#!/bin/sh
# $Id: preprocessing.sh,v 1.1 2011-10-04 15:48:29 henes Exp $

echo "Preprocessing..."

. ./config
rc=$?

if [ $rc -eq 0 ]; then
	ARCH=$TARGET

	CURDIR=`pwd` || exit 1
	DST="$CURDIR"/tree
	mkdir -p "$DST"/$ARCH/lib || exit 1
	TMP=`mktemp -td dmdsdk.XXXXXXXXXX` || exit 1

	cd "$TMP"

	for i in $KERNEL $LIBC $LIBCDEV $LIBEXPATDEV $LIBZDEV $LIBCXX $LIBALSADEV;
	do
		if [ $rc -eq 0 ]; then
			echo "Decompressing $i..."
			cat "$CURDIR"/"$i" | tar -xj
			rc=$?
		fi
	done

	if [ $rc -eq 0 ]; then
		echo "Copying required files..."
		cp -a "$TMP"/lib "$DST"/$ARCH && cp -a "$TMP"/usr/include "$DST"/$ARCH && cp -a "$TMP"/usr/lib "$DST"/$ARCH
		rc=$?
	fi

	if [ $rc -eq 0 ]; then
		echo "Fixing softlinks..."
		cd "$DST"/$ARCH/lib && ls -l --time-style=long-iso | grep "/lib" | sed 's|/lib/||' | awk '{ print "ln -sf", $10, $8 }' >fixit
		rc=$?
		if [ $rc -eq 0 ]; then
			sh fixit
			rm fixit
			cd "$DST"/$ARCH/lib/nptl && ls -l --time-style=long-iso | grep "/lib" | sed 's|/lib/|../|' | awk '{ print "ln -sf", $10, $8 }' >fixit
			rc=$?
			if [ $rc -eq 0 ]; then
				sh fixit
				rm fixit
			fi
		fi
	fi

	if [ $rc -eq 0 ]; then
		cat "$TMP"/usr/lib/libc.so | sed 's|/usr/|/|g' | sed 's|/lib/|'"$DST"/$ARCH/lib/'|g' >"$DST"/$ARCH/lib/libc.so
		rc=$?
	fi
	if [ $rc -eq 0 ]; then
		cat "$TMP"/usr/lib/libpthread.so | sed 's|/usr/|/|g' | sed 's|/lib/|'"$DST"/$ARCH/lib/'|g' >"$DST"/$ARCH/lib/libpthread.so
		rc=$?
	fi

	echo "Cleaning temporary stuff..."
	cd "$CURDIR"
	rm -rf $TMP
fi

exit $rc
