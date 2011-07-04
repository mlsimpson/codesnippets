def s
    "def s;;end;puts s()[0,6]+34.chr+s+34.chr+s()[6,s.length-6]"
end
puts s()[0,6]+34.chr+s+34.chr+s()[6,s.length-6]
puts "\n"
puts s
puts "\n"
puts s()[0,6]
puts "\n"
puts s[0,6]
