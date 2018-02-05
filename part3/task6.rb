# сумма покупок
goods = {}

loop do
  puts 'Enter name of good :'
  good = gets.chomp.to_s
  break if good == 'stop'

  puts 'Enter cost of good:'
  cost = gets.chomp.to_f

  puts 'Enter number of goods that you bought:'
  number = gets.chomp.to_i

  hash_of_goods = { cost: cost, number: number }
  goods[good] = hash_of_goods
end

puts goods

common_cost = 0
goods.each do |name, amount|
  common_cost += amount[:cost] * amount[:number]
  puts "total cost of #{name} is: #{amount[:cost] * amount[:number]}"
end
puts "total cost of all goods: #{common_cost}"
