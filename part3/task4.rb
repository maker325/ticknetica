# гласные буквы
h = {}
number = 1
for symbol in 'a'..'z'
  h[symbol] = number
  number += 1
end
h.delete_if { |k, _v| k.count('aeiou') == 0 }
puts h
