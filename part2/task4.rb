puts "Программа определит корни квадратного уравнения a*x**2 + b*x + c = 0, введите 3 коэффициента a, b, c:"
a = gets.chomp.to_f
b = gets.chomp.to_f
c = gets.chomp.to_f
d = b**2 - 4 * a * c

if d > 0
  e = Math.sqrt(d)
  puts "D = #{d}, x1=#{0.5 * (-b + e) / a}, x1=#{0.5 * (-b - e) / a}"
elsif d == 0
  puts "D = #{d}, x=#{0.5 * (-b) / a}"
else
  puts "D = #{d}, Корней нет."
end
