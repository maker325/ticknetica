puts "Программа определит вид треугольника, для этого введите размеры 3 сторон треугольника:"
a1 = gets.chomp.to_f
b1 = gets.chomp.to_f
c1 = gets.chomp.to_f

sides = [a1, b1, c1].sort!
a = sides[0]
b = sides[1]
c = sides[2]

case1 = c**2 == a**2 + b**2
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
