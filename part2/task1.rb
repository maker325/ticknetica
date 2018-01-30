puts "Enter your name please:"
name = gets.chomp
name.capitalize!

puts "Enter your height please:"
height = gets.chomp
weight = (height.to_i - 110)

if weight > 0
  puts "#{name}, your ideal weight is #{weight}."
else
  puts "Your weight is already perfect!"
end
