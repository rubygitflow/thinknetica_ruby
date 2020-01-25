def check_exit(inp)
	["exit", "quit", "close"].include?(inp.downcase)
end

def check_input(inp,type)
	case type
	when 0
		(inp.class == String) && (inp.size > 0)
	when 1
		(inp.class == Integer) && (inp > 0)
	else
		false
	end
end

def result(name, height)
	weight = (height - 110) * 1.15
	if weight < 0.0 
		puts "#{name}. Ваш вес уже идеальный"
	else
		puts "{name}. Ваш вес: #{weight}"
	end
end

def dialogue(name)
	print "Ваш рост в сантиметрах: "
	height = gets.chomp
	if check_exit(height) 
		puts "Bye-bye, #{name}!"
	else
		height = height.to_i
		if check_input(height, 1)
			result(name, height)
		else
			dialogue(name)
		end
	end
end

def main
	print "Ваше имя: "
	name = gets.chomp!.capitalize
	if check_exit(name)
		puts "Bye-bye!"
	elsif check_input(name, 0)
		dialogue(name)
	else
		main
	end
end

main
