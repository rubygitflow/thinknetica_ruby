def check_exit(inp)
	["exit", "quit", "close"].include?(inp.downcase)
end

def check_input(inp,type)
	case type
	when 0
		(inp.class == String) && (inp.size > 0)
	when 1
		(inp.class == Integer) && (inp > 0)
	when 2
		(inp.class == Float) && (inp > 0)
	else
		false
	end
end

def calculate(b, h)
	0.5 * b * h
end

def get_var(description)
	print description
	inp = gets.chomp
	exit if check_exit(inp)
	res = inp.gsub(',', '.').to_f
	res = get_var(description) unless check_input(res, 2)
	res
end


def main
	base = get_var("Высота треугольника: ")
	height = get_var("Основание треугольника: ")

	puts "Размеры треугольника: #{base} #{height}"
	aria = calculate(base, height).round(3)
	puts "Площадь треугольника: #{aria}"
end

main
