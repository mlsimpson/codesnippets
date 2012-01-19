#!/bin/sh

if [ -n "$1" -a -n "$2" ]

then

  PLOTLOC=`which gnuplot`

  # move the gnuplot instructions to ~/abgraph-plotme
  echo "set terminal png size 1024,768
  set output '$1'
  set title 'Benchmark results of $1'
  set size 1,1
  set key left top
  set xlabel 'request'
  set ylabel 'ms'
  plot '~/abmark-bench1' using 10 with lines title 'Benchmark 1 ($2 requests, 1 concurrent)', '~/abmark-bench2' using 10 with lines title 'Benchmark 2 ($2 requests, 25 concurrent)', '~/abmark-bench3' using 10 with lines title 'Benchmark 3 ($2 requests, 50 concurrent)', '~/abmark-bench4' using 10 with lines title 'Benchmark 4 ($2 requests, 100 concurrent)'
  " > ~/abgraph-plotme

  # generate graph (png saved to user selected path by gnuplot)
  $PLOTLOC ~/abgraph-plotme > /dev/null

  echo "The graph has been saved to $1";

  # tidy up
  rm ~/abgraph-plotme

  eog $1&

else

  # display error message on wrong usage
  echo "Usage: gplotabmark.sh [graph name] [number of requests]"
  echo "e.g: ./gplotabmark.sh graph.png 500"
  echo " "
  echo "abmark-bench(1,4) MUST be present in home directory!"

fi
