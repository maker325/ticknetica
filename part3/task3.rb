# фибоначчи
arr = [0, 1]
data = 0
while  data <= 100
  data = arr[-1] + arr[-2]
  arr << data if data <= 100

end

puts arr.to_s
