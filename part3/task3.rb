# фибоначчи
arr = [0, 1]
data = 0
loop do
  data = arr[-1] + arr[-2]
  arr << data if data <= 100
  break if data >= 100
end

puts arr.to_s
