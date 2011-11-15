#!/bin/bash

read -p "How many seconds should I run?  (Enter '0' for endless loop, Ctrl+C to stop) ==> " count_secs

if [ $count_secs -eq 0 ]
then
  count_secs=""
fi

script -c "mpstat 1 $count_secs" -q temp.txt
echo ""
awk '{if ($4 ~/[0-9]\.[0-9]/) num=$4}; num > m { m = num } END { print "Max CPU Usage:  "m"%" }' temp.txt
rm -f temp.txt
