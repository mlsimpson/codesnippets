x = ARGV[0].to_i

start = Time.now

s = (0..x.to_i).to_a

s[0] = s[1] = nil

s.each{ |p|
  next unless p # Iterate on next array value if entry is nil
  break if p * p > x # Cease iteration if p*p > max_value
  (p*p).step(x, p) { |m| s[m] = nil } # Starting at p^2, set every p-th value to "nil" until max_value
}

s = s.compact

puts s.join(" ")

finish = Time.now

print "Elapsed time:  #{(finish - start)*1000} milliseconds\n"
