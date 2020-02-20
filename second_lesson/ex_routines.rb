def check_exit(input)
  ['exit', 'quit', 'close', 'стоп'].include?(input.downcase)
end

def check_input(input, type)
  case type
  when 0
    input.class == String && input.size > 0
  when 1
    input.class == Integer && input > 0
  when 2
    input.class == Float && input >= 0
  when 3
    (input.class == String && input.size > 0) || (input.class == Integer && input > 0)
  else
    false
  end
end
