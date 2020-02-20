multiple5 = []
(10..100).each do |val|
  multiple5 << val if (val % 5) == 0
end
puts "multiple of 5 = #{multiple5.inspect}"
