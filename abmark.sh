#!/bin/sh

# $1 = hostname to benchmark
# $2 = where to output the PNG file
# $2 = number of requests (must be over 100)

VERSION="Version 1.0"

# find out location of ab
ABLOC=`which ab`

echo -e  "This is abmark $VERSION";

# check if all needed parameters are given
if [ -n "$1" -a -n "$2" ]

then

	# first benchmark
	echo -e  "Benchmarking... 1/3 ($2 HTTP requests)";
	$ABLOC -n $2 -g /tmp/abmark-data1 $1 > /dev/null
	echo -e  -e "\nGreat.  Continuing...";

	# sleep 5 seconds
	echo -e  "\nsleeping 5 seconds..."
	sleep 5

	# second benchmark
	echo -e  "Benchmarking... 2/3 ($2 HTTP requests, simulating 25 concurrent users)";
	$ABLOC -n $2 -c 25 -g /tmp/abmark-data2 $1 > /dev/null
	echo -e  "\nOkay.  Continuing...";

	# sleep 5 seconds
	echo -e  "\nsleeping 5 seconds..."
	sleep 5

	# third benchmark
	echo -e  "Benchmarking... 3/3 ($2 HTTP requests, simulating 50 concurrent users)";
	$ABLOC -n $2 -c 50 -g /tmp/abmark-data3 $1 > /dev/null

	echo -e  "\nLooks good. Finished!";

	# tidy up
	mv /tmp/abmark-data1 ~/abmark-bench1
	mv /tmp/abmark-data2 ~/abmark-bench2
	mv /tmp/abmark-data3 ~/abmark-bench3

else

	# display error message on wrong usage
	echo -e  "Usage: abmark [hostname to benchmark with http:// and trailing /] [number of requests]"
	echo -e  "e.g: ./abmark http://example.com/ 500"

fi