# гласные буквы
h = {}
('a'..'z').each_with_index { |item, index| h[item] = index if item.count('aeiou') != 0 }

puts h
