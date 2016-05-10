#!/bin/bash

E_NOPATTERN=71
DICT=/usr/share/dict/linux.words

#You can download words or linux.words from website and install it (rpm -Uvh)
#(https://pkgs.org/centos-6/centos-i386/words-3.0-17.el6.noarch.rpm.html)

if [ -z "$1" ]
then
	echo
	echo "`basename $0` \"pattern,\""
	echo "where \"pattern\" is in the form"
	echo "000.00.0..."
	echo
	echo "The 0's are letters you alredy know,"
	echo "and the periods are missing letters."
	echo "Letters and periods can be in any position."
	echo "For example: w....i.....n"
	echo
	exit $E_NOPATTERN
fi

grep ^"$1"$ "$DICT"
