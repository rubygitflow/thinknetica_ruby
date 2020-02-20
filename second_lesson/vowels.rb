vowels = {}
('a'..'z').each_with_index do |val, index|
  (vowels[val] = index + 1)  if ['e','u','i','o','a'].include?(val)
end
puts "vowels = #{vowels.inspect}"
