
one = 0
two = 1
counter = 1
sum = 0
goal = 42_000

while counter <= goal
  if counter % 2 == 0
    one = one + two
    sum += one
  else
    two = one + two
    sum += two
  end

  counter += 1
end

File.open('42000_light_years_energy.txt', 'w') {|f| f.write(sum)}
puts sum
