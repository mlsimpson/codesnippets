#!/usr/bin/env ruby

def avg *args
  args.inject(:+).to_f / args.length
end

def sqrt *args
  if args.length != 1
    p "sqrt X needs one and only one argument"
    return
  end
  x = args[0]
  g = 1.0
  og = 0
  while og != g
    og = g
    g = avg(g, x/g)
  end
  g
end

sqrhash = Hash.new
(1..10000).each do |i|
  sqrhash[i] = sqrt(i)
end

p sqrhash
