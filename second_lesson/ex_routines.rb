def check_exit(inp)
  ['exit', 'quit', 'close', 'стоп'].include?(inp.downcase)
end

def check_input(inp, type)
  case type
  when 0
    (inp.class == String) && (inp.size > 0)
  when 1
    (inp.class == Integer) && (inp > 0)
  when 2
    (inp.class == Float) && (inp >= 0)
  when 3
    ((inp.class == String) && (inp.size > 0) )|| ((inp.class == Integer) && (inp > 0))
  else
    false
  end
end
