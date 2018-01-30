puts "Программа определит вид треугольника, для этого введите размеры 3 сторон треугольника:"
a1 = gets.chomp
b1 = gets.chomp
c1 = gets.chomp
a = a1.to_i
b = b1.to_i
c = c1.to_i

c1 = ((a > b) && (a > c)) && (a*a == b*b + c*c)
c2 = ((b > a) && (b > c)) && (b*b == a*a + c*c)
c3 = !(c1 || c2) && (c*c == a*a + b*b)
case1 = c1 || c2 || c3
case2 = (a == b) && (b == c)
case3 = (a == b) || (a == c) || (b == c)

if case1
  puts "Треугольник прямоугольный"
end

if case2
  puts "Треугольник равнобедренный и равноcторонний"
end

if case3 && !case2
  puts "Треугольник равнобедренный"
end

if !((case1) || (case3))
  puts "Треугольник обычный"
end
