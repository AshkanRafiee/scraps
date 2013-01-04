#!/bin/bash -i

if [ $# -gt 0 ] ; then
	# Expand if $1 is an alias
	if [ $(alias -p | awk -F "[ =]" '{print $2}' | grep -x $1) -gt 0 ] ; then
		set -- $(alias $1 | awk -F "['']" '{print $2}') "${@:2}"
	fi
	($@ &) &>/dev/null
else
	echo "missing argument"
fi
