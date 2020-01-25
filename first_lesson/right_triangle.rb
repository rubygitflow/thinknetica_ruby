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

def calculate_type_of_triangle(a, b, c)
	l = [a, b, c].sort!
	r = l[2]

    if r**r.round(3) == (l[0]**l[0] + l[1]**l[1]).round(3)
    	"Прямоугольный"
    elsif (a == b) && (b == c)
    	"Равносторонний"
	elsif (a == b) || (b == c) || (c == a)
		"Равнобедренный"
	else
		"Разносторонний"
	end
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
	puts "Введите длины сторон треугольника"
	a = get_var("Сторона a: ")
	b = get_var("Сторона b: ")
	c = get_var("Сторона c: ")
	
	type = calculate_type_of_triangle(a, b, c)
	puts "Треугольник: #{type}"
end

main
