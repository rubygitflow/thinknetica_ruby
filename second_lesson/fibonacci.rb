def search_fibonacci(a)
  fib = [1, 1]
  # исключаем ошибки работы процедуры
  return fib, -1 if a < 1
  # достраиваем массив
  while (new_number = fib[-1] + fib[-2]) < a
    fib << new_number
  end
  return fib
end

fib = search_fibonacci(100)

puts "Массив Фибоначчи:"
fib.each_with_index { |number, index| puts "#{index} => #{number}" }
