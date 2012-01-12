#!/bin/sh

## Copyright 2007 Lennart Koopmann [lennart@dev-my.org]
##
## This program is distributed under the terms of the GNU General Public License (GPL)

VERSION="Version 1.0 (01.09.2007) \n"

## TODO: check if host is up |

########
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program. If not, see .
########

# $1 = hostname to benchmark
# $2 = where to output the PNG file
# $3 = number of requests (must be over 100)

# find out location of ab
ABLOC=`which ab`

#find out location if gnuplot
PLOTLOC=`which gnuplot`

echo "This is ABGraph $VERSION";

# check if all needed parameters are given
if [ -n "$1" -a -n "$2" -a -n "$3" ]

then

# move the gnuplot instructions to /tmp/abgraph-plotme
echo "set terminal png
set output '$2'
set title 'Benchmark results of $1'
set size 2,1
set key left top
set xlabel 'request'
set ylabel 'ms'
plot '/tmp/abgraph-data1' using 10 with lines title 'Benchmark 1 ($3/1)', '/tmp/abgraph-data2' using 10 with lines title 'Benchmark 2 ($3/25)', '/tmp/abgraph-data3' using 10 with lines title 'Benchmark 3 ($3/50)'
" > /tmp/abgraph-plotme

# first benchmark
echo "Benchmarking... 1/3 ($3 HTTP requests)";
$ABLOC -n $3 -g /tmp/abgraph-data1 $1 > /dev/null
echo "Great.\nContinuing...";

# sleep 5 seconds
echo "\nsleeping 5 seconds...\n"
sleep 5

# second benchmark
echo "Benchmarking... 2/3 ($3 HTTP requests, simulating 25 concurrent users)";
$ABLOC -n $3 -c 25 -g /tmp/abgraph-data2 $1 > /dev/null
echo "Okay.\nContinuing...";

# sleep 5 seconds
echo "\nsleeping 5 seconds...\n"
sleep 5

# third benchmark
echo "Benchmarking... 3/3 ($3 HTTP requests, simulating 50 concurrent users)";
$ABLOC -n $3 -c 50 -g /tmp/abgraph-data3 $1 > /dev/null

echo "Looks good. Finished!\n";

# generate graph (png saved to user selected path by gnuplot)
$PLOTLOC /tmp/abgraph-plotme > /dev/null

echo "The graph has been saved to $2";

# tidy up
rm /tmp/abgraph-data1
rm /tmp/abgraph-data2
rm /tmp/abgraph-data3
rm /tmp/abgraph-plotme

eog $2

else

# display error message on wrong usage
echo "Usage: abgraph [hostname to benchmark with http:// and trailing /] [output file .png] [number of requests]"
echo "e.g: ./abgraph http://example.com/ /home/myhome/graph.png 500"

fi
