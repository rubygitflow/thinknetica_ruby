load 'ex_routines.rb'

def get_year(description)
  print description 
  input = gets.chomp
  exit if check_exit(input)
  year = input.to_i
  year = get_year(description) unless check_input(year, 1)
  year
end

def check_month(description)
  months = [['january','jan','1','01'],
            ['februrary','feb','2','02'],
            ['march','mar','3','03'],
            ['april','apr','4','04'],
            ['may','5','05'],
            ['june','6','06'],
            ['jule','7','07'],
            ['august','aug','8','08'],
            ['september','sept','9','09'],
            ['oktober','okt','10'],
            ['november','nov','11'],
            ['december','dec','12']
          ]
  months.each_with_index{ |arr,index| 
    return index + 1 if arr.include?(description.to_s.downcase)
  }
  nil
end

def get_month(description)
  print description 
  input = gets.chomp
  exit if check_exit(input)
  month = get_month(description) unless check_input(input, 3)
  month = check_month(input)
  puts "month=#{month.inspect}"
  month = get_month(description) if month.nil?
  month
end

def leap_year?(year)
  year % 4 == 0 && year % 100 != 0 || year % 400 == 0
end

def date_by_month(year)
  date_by_month = {1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 
                   6 => 30, 7 => 31, 8 => 31, 9 => 30, 10 => 31, 
                   11 => 30, 12 => 31}
  date_by_month[2] = 29 if leap_year?(year)
  date_by_month
end

def check_date(description, year, month)
  date_by_month(year)[month] >= description
end

def get_day(description, year, month)
  print "#{year}.#{month}.#{description}"
  input = gets.chomp
  exit if check_exit(input)
  day = input.to_i
  day = get_day(description, year, month) unless check_input(day, 1)
  day = get_day(description, year, month) unless check_date(day, year, month)
  day
end

def date_of_year(day, month, year)
  month_dates = date_by_month(year)
  result = month_dates.take(month-1).sum(0){|month, day| day}
  result += day
  result
end

puts "Введите дату"
year = get_year('Год: ')
month = get_month('Месяц: ')
day = get_day('Дата: ', year, month)
output = date_of_year(day,month, year)
puts "День в году (порядковый номер даты): #{output}"
