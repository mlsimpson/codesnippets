#!/usr/bin/env ruby -wKU
if (ARGV[0]).nil?
  puts "No input file specified; exiting"
  exit
end

data = []
file = File.new(ARGV[0])

while line = file.gets
  data << line.split
end

file.close

# For each word, keep the 1st and last letter in place.
# Randomize all the other letters.
# Print end result to stdout

data.each{|line|
  line.map!{|word|
    orig = word.chars.to_a
    word = word.chars.to_a
    newmid = word[1..-2]
    if newmid.length > 1
      while newmid == word[1..-2]
        newmid.shuffle!
      end
      # Go through each letter.  If each letter is the same as the previous word, switch it.
      i = 0
      while i < newmid.length
        while newmid[i] == orig[1 + i]
          x = rand(newmid.length)
          temp = newmid[i]
          newmid[i] = newmid[x]
          newmid[x] = temp
        end
        i += 1
      end
      word[1..-2] = newmid
    end
    word = word.to_s
  }
  puts line.join(' ')
}
