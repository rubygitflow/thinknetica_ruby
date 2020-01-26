load 'ex_routines.rb'

def calculate_discremenant(a, b, c)
  b**2 - 4 * a * c
end

def calculate_roots_equention(a, b, c, d)
  if d < 0
    return nil, nil
  elsif d.round(8) == 0.0
    return -b / ( 2 * a ) , nil
  else # d > 0
    e = Math.sqrt(d)
    return -b + e / ( 2 * a ) , -b - e / ( 2 * a )
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
  puts "Решение квадратного уравнения"
  a = get_var("Коэффициент a: ")
  b = get_var("Коэффициент b: ")
  c = get_var("Коэффициент c: ")
  
  d = calculate_discremenant(a, b, c)
  re1, re2 = calculate_roots_equention(a, b, c, d)

  puts "Дискриминант: #{d.round(3)}"
  if d > 0 
    puts "Корни: #{re1.round(3)} ; #{re2.round(3)}"
  elsif d == 0
    puts "Корень: #{re1.round(3)}"
  else # d <0
    puts "Корней нет"
  end
end

main
