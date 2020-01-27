load 'ex_routines.rb'

def result(name, height)
  weight = ((height - 110) * 1.15).round(1)
  if weight < 0.0 
    puts "#{name}. Ваш вес уже идеальный"
  else
    puts "#{name}. Ваш вес: #{weight}"
  end
end

def dialogue(name)
  print 'Ваш рост в сантиметрах: '
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
  print 'Ваше имя: '
  name = gets.chomp!.capitalize
  if check_exit(name)
    puts 'Bye-bye!'
  elsif check_input(name, 0)
    dialogue(name)
  else
    main
  end
end

main
