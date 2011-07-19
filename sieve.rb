arg = ARGV[0].to_i

def sieve(x)
  s = (0..x.to_i).to_a

  s[0] = s[1] = nil

  s.each{ |p| # Perform the block for each entry in the array.
    next unless p # Iterate on next array value if entry is nil
    break if p * p > x # Cease iteration if p*p > max_value
    (p*p).step(x, p) { |m| s[m] = nil } # Starting at p*p, set every p-th value to "nil" until max_value
  }
  s = s.compact
  puts s.join(" ")
end

def timing_method(block=nil, *args)
  start = Time.now
  if block_given?
    yield
  else
    self.send(block, args)
  end
  finish = Time.now
  print "Elapsed time:  #{(finish - start)*1000} milliseconds\n"
end

timing_method do
  sieve(arg)
end
