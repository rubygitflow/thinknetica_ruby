load 'ex_routines.rb'

@basket = {}

def get_string(description)
  print description
  input = gets.chomp
  if check_exit(input)
    nil
  else
    if check_input(input, 0) 
      result = input
    else
      result = get_string(description) 
    end
    result
  end
end

def get_float(description)
  print description
  input = gets.chomp
  result = input.gsub(',', '.').to_f
  result = get_float(description) unless check_input(result, 2)
  result
end

def purchase_amount
  puts "Корзина покупок:"
  puts "#{@basket.inspect}"

  total_sum = 0
  puts "Суммы по видам покупок:"
  @basket.each_pair{|item, price_count| 
    sum = price_count.sum(0.0){|price, count| price*count}
    puts "#{item} => #{sum}" 
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
    @basket.merge!(new_pos){|key, oldval, newval| 
      oldval.merge!(newval){|inner_key, inner_oldval, inner_newval| 
        inner_oldval+inner_newval
      }
    } 
    puts "Следующая покупка (для выхода набери 'стоп' или 'exit')"
    input_purchase
  end
end

input_purchase
