#!/bin/sh

# $1 = hostname to benchmark
# $2 = where to output the PNG file
# $2 = number of requests (must be over 100)

VERSION="Version 1.0"

# find out location of ab
ABLOC=`which ab`

# Try ab -v4 :: verbosity level 4
# -C 'NAME=CONTENT'
# Insert the following into a php page after login
# <?php global $user; print 'This is user: '. $user->name .' : UID:'. $user->uid; ?>

echo   "This is abmark $VERSION";

# check if all needed parameters are given
if [ -n "$1" -a -n "$2" ]

then

	# first benchmark
	echo   "Benchmarking... 1/4 ($2 HTTP requests)";
	$ABLOC -n $2 -g /tmp/abmark-data1 $1 > /dev/null
	echo    "\nGreat.  Continuing...";

	# sleep 5 seconds
	echo   "\nsleeping 5 seconds..."
	sleep 5

	# second benchmark
	echo   "Benchmarking... 2/4 ($2 HTTP requests, simulating 25 concurrent users)";
	$ABLOC -n $2 -c 25 -g /tmp/abmark-data2 $1 > /dev/null
	echo   "\nOkay.  Continuing...";

	# sleep 5 seconds
	echo   "\nsleeping 5 seconds..."
	sleep 5

	# third benchmark
	echo   "Benchmarking... 3/4 ($2 HTTP requests, simulating 50 concurrent users)";
	$ABLOC -n $2 -c 50 -g /tmp/abmark-data3 $1 > /dev/null

	echo   "\nOne more...";

	# sleep 5 seconds
	echo   "\nsleeping 5 seconds..."
	sleep 5

	# third benchmark
	echo   "Benchmarking... 4/4 ($2 HTTP requests, simulating 100 concurrent users)";
	$ABLOC -n $2 -c 100 -g /tmp/abmark-data4 $1 > /dev/null

	echo   "\nLooks good. Finished!";

	# tidy up
	mv /tmp/abmark-data1 ~/abmark-bench1
	mv /tmp/abmark-data2 ~/abmark-bench2
	mv /tmp/abmark-data3 ~/abmark-bench3
	mv /tmp/abmark-data4 ~/abmark-bench4

else

	# display error message on wrong usage
	echo   "Usage: abmark [hostname to benchmark with http:// and trailing /] [number of requests]"
	echo   "e.g: ./abmark http://example.com/ 500"

fi
