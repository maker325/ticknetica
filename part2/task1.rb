puts "Enter your name please:"
name = gets.chomp.capitalize

puts "Enter your height please:"
height = gets.chomp.to_f
weight = (height - 110)

if weight > 0
  puts "#{name}, your ideal weight is #{weight}."
else
  puts "Your weight is already perfect!"
end
