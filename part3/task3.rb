# фибоначчи
arr = [0, 1]
data = 0 # если исполльзую while понадобится это присвоение, если loop, то он не нужен
while  data <= 100
  data = arr[-1] + arr[-2]
  arr << data if data <= 100
end

puts arr.to_s
