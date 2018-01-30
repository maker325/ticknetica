puts "Программа определит корни квадратного уравнения a*x**2 + b*x + c = 0, введите 3 коэффициента a, b, c:"
a1 = gets.chomp
b1 = gets.chomp
c1 = gets.chomp
a = a1.to_i
b = b1.to_i
c = c1.to_i
d = b**2 - 4*a*c

if d > 0
  puts "D = #{d}, x1=#{0.5*(-b + Math.sqrt(d))/a}, x1=#{0.5*(-b - Math.sqrt(d))/a}"
elsif d == 0
  puts "D = #{d}, x=#{0.5*(-b)/a}"
else
  puts "D = #{d}, Корней нет."
end
