#!/bin/bash -i

if [ $# -gt 0 ] ; then
	# Expand if $1 is an alias
	ALIAS=$(alias $1 2>/dev/null | awk -F "['']" '{print $2}')
	if [ -n "$ALIAS" ] ; then
		set -- $ALIAS "${@:2}"
	fi
	($@ &) &>/dev/null
	exit 0
else
	echo "missing argument"
	exit 1
fi
