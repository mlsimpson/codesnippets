def sieve(x)
  s = (0..x.to_i).to_a

  s[0] = s[1] = nil

  s.each{ |p| # Perform the block for each entry in the array.
    next unless p # Iterate on next array value if entry is nil
    break if p * p > x # Cease iteration if p*p > max_value
    (p*p).step(x, p) { |m| s[m] = nil } # Starting at p*p, set every p-th value to "nil" until max_value
  }
  s = s.compact
end

primes = sieve(10000)

amicable_array = Array.new

amicable_max = 0
n = 4

# while amicable_max < 10000
  p = 3*(2**(n-1)) - 1
  puts "p = #{p}"
  if primes.include?(p)
    q = 3*(2**n) - 1
    puts "q = #{q}"
    if primes.include?(q)
      r = 9*(2**(2*n - 1)) - 1
      puts "r = #{r}"
      if primes.include?(r)
        a1 = p*q*(2**n)
        puts a1
        amicable_array << a1
        a2 = r*(2**n)
        puts a2
        amicable_array << a2
        amicable_max = [a1, a2].max
      end
    end
  end
  # n += 1
# end

p amicable_array
