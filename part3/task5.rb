# порядковый номер дня года
puts 'Enter day:'
day = gets.chomp.to_i
puts 'Enter month:'
month = gets.chomp.to_i
puts 'Enter year:'
year = gets.chomp.to_i

amount_of_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
amount_of_days[1] = 29 if (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
number = 0

for x in (0..month - 2)
  number += amount_of_days[x]
end

number = day + number

print "the ordinal number of this day is #{number}"
