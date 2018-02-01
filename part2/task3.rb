puts "Программа определит вид треугольника, для этого введите размеры 3 сторон треугольника:"
a1 = gets.chomp.to_f
b1 = gets.chomp.to_f
c1 = gets.chomp.to_f

sides = [a1, b1, c1].sort!
cathetus1 = sides[0]
cathetus2 = sides[1]
hypotenuse = sides[2]

case1 = hypotenuse**2 == cathetus1**2 + cathetus2**2
case2 = (cathetus1 == cathetus2) && (cathetus2 == hypotenuse)
case3 = (cathetus1 == cathetus2) || (cathetus1 == hypotenuse) || (cathetus2 == hypotenuse)

puts "Треугольник прямоугольный" if case1
puts "Треугольник равнобедренный и равноcторонний" if case2
puts "Треугольник равнобедренный" if case3 && !case2
puts "Треугольник обычный" if !((case1) || (case3))
