#!/usr/bin/env ruby

puts "With special characters:"
puts ('!'..')').to_a.delete_if{|char| char == "\"" || char == "'"}.shuffle[0..1].join + ('a'..'z').to_a.concat(('A'..'Z').to_a).shuffle[0..7].join + ('0'..'9').to_a.shuffle[0..2].join
puts
puts "Without special characters:"
puts ('a'..'z').to_a.concat(('A'..'Z').to_a).shuffle[0..7].join + ('0'..'9').to_a.shuffle[0..2].join
