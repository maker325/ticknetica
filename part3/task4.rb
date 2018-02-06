# гласные буквы
h = {}
('a'..'z').to_a.each_with_index { |item, index| h[item] = index }
h.delete_if { |k, _v| k.count('aeiou') == 0 }
puts h
