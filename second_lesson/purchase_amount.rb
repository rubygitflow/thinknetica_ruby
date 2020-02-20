load 'ex_routines.rb'

$basket = {}

def get_string(description)
  print description
  inp = gets.chomp
  if check_exit(inp)
    nil
  else
    if check_input(inp, 0) 
      res = inp
    else
      res = get_string(description) 
    end
    res
  end
end

def get_float(description)
  print description
  inp = gets.chomp
  res = inp.gsub(',', '.').to_f
  res = get_float(description) unless check_input(res, 2)
  res
end

def purchase_amount
  puts "Корзина покупок:"
  puts "#{$basket.inspect}"

  total_sum = 0
  puts "Суммы по видам покупок:"
  $basket.each_pair{|key, value| 
    local_arr = value.to_a
    sum = 0
    local_arr.each { |val|
      sum += val[0] * val[1]
    }
    puts "#{key} => #{sum}" 
    total_sum += sum
  }
  
  puts "Итоговая сумма всех покупок в корзине: #{total_sum.inspect}"
end

def input_purchase
  name = get_string('Название товара: ')
  if name.nil?
    purchase_amount
  else
    price = get_float('Цена за единицу: ')
    amount = get_float('Кол-во товара: ')
    new_pos = {name => {price => amount}}
    $basket.merge!(new_pos){|key, oldval, newval| 
      oldval.merge!(newval){|inner_key, inner_oldval, inner_newval| 
        inner_oldval+inner_newval
      }
    } 
    puts "Следующая покупка (для выхода набери 'стоп' или 'exit')"
    input_purchase
  end
end

input_purchase