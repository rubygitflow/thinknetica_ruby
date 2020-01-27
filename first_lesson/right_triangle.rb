load 'ex_routines.rb'

def calculate_type_of_triangle(a, b, c)
  a, b, h = [a, b, c].sort

  if (h**2).round(3) == (a**2 + b**2).round(3)
    'Прямоугольный'
  elsif (a == b) && (b == h)
    'Равносторонний'
  elsif (a == b) || (b == h) || (h == a)
    'Равнобедренный'
  else
    'Разносторонний'
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
  puts 'Введите длины сторон треугольника'
  a = get_var('Сторона a: ')
  b = get_var('Сторона b: ')
  c = get_var('Сторона c: ')
  
  type = calculate_type_of_triangle(a, b, c)
  puts "Треугольник: #{type}"
end

main
