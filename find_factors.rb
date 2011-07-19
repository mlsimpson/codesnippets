#!/usr/bin/env ruby

require 'timing_method'

a = 2

x = ARGV[0].to_i
max = ARGV[1].to_i

if max <= 0
  puts "usage:  #{$0} <number to factor> <max numbers to test if factor>"
  exit
end

timing_method do
  while a < max
    # print "#{x} % #{a} = "
    if x%a == 0
      puts "#{a} is a factor of #{x}"
    end
    # print modresult
    a += 1
  end
end
