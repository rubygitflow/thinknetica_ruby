def search_fibonacci(a)
  fib = [1, 1]
  # исключаем ошибки работы процедуры
  return fib, -1 if a < 1
  last_ind = 1
  # достраиваем массив
  while fib[-1] < a
    last_ind = fib.length
    fib << fib[last_ind - 1] + fib[last_ind - 2]
  end
  # на случай многократного использования процедуры ищем ближайшее значение из массива больше a
  last_ind = fib.length
  last_ind_pred = last_ind - 1
  while fib[last_ind_pred] > a
    last_ind_pred -= 1
  end
  return fib, last_ind_pred
end

fib, last_ind = search_fibonacci(100)

puts "Массив Фибоначчи:"
(0..last_ind).each {|ind| puts "#{ind} => #{fib[ind]}"}
