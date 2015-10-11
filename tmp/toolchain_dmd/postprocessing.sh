#!/bin/sh
# $Id: postprocessing.sh,v 1.4 2011-10-17 12:05:05 henes Exp $

echo "Postprocessing..."

. ./config
rc=$?

if [ $rc -eq 0 ]; then
	ARCH=$TARGET

	CURDIR=`pwd` || exit 1
	DST="$CURDIR"/tree

	echo "Tweaking specs file..."
	# Remove local include paths
	sed -e '/^\*cpp:$/{n;s|^\(.*\)$|-nostdinc -isystem '"$DST"'/lib/gcc/'$ARCH'/'$GCC_VERSION'/include -isystem '"$DST"'/'$ARCH'/include -isystem '"$DST"'/include \1|}' \
	    -i "$DST"/lib/gcc/$ARCH/$GCC_VERSION/specs \
	&& sed -e '/^\*cc1plus:$/{n;s|^\(.*\)$|-nostdinc++ -isystem '"$DST"'/include/c++/'$GCC_VERSION' \1|}' \
	    -i "$DST"/lib/gcc/$ARCH/$GCC_VERSION/specs
	rc=$?
fi

exit $rc
