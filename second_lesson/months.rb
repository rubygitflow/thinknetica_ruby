months2020 = {january: 31, februrary: 29, march: 31, april: 30, may: 31, 
              june: 30, jule: 31, augest: 31, september: 30, october: 31, 
              november: 30, december: 31}
puts "Печать месяцев с количеством дней равном 30:"
months2020.each { |month, day| puts "#{month}\n" if day==30 }
