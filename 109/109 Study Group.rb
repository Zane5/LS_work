#109 March 14th

Write a method that computes the difference between the square of the sum of
the first n positive integers and the sum of the squares of the first n positive
integers.

sum_square_difference(3) == 22
   # -> (1 + 2 + 3)**2 - (1**2 + 2**2 + 3**2)
sum_square_difference(10) == 2640
sum_square_difference(1) == 0
sum_square_difference(100) == 25164150

# Input
# An integer
# Output
# Sum all n positive numbers and then calculate its square
# calculate the square of all numbers them sum them
# subtract both blocks

# Algorithm

#Use a range, transform in an array, and sum all of them

def sum_square_difference(a_num)
  first_block = (1..a_num).to_a.reduce(&:+)
  first_block **=2

  second_block = (1..a_num).to_a.map { |number| number ** 2 }
  second_block = second_block.reduce(&:+)

  first_block - second_block
end

def sum_square_difference(num)
  square_of_sum = ((1..num).inject(:+)) ** 2
  sum_of_square = (1..num).map { |e| e ** 2 }.inject(:+)
  return (square_of_sum - sum_of_square)
end

def sum_square_difference(n)
  sum = 0
  sum_of_squares = 0

  1.upto(n) do |value|
    sum += value
    sum_of_squares += value**2
  end

  sum**2 - sum_of_squares
end

#################
sum =0
def sum_of_sums(arr, sum)
  0.upto(arr.size-1) do |i|
    sum += arr[0..i].reduce(&:+)
  end
  sum
end


sum_of_sums([3, 5, 2]) == (3) + (3 + 5) + (3 + 5 + 2) # -> (21)
sum_of_sums([1, 5, 7, 3]) == (1) + (1 + 5) + (1 + 5 + 7) + (1 + 5 + 7 + 3) # -> (36)
sum_of_sums([4]) == 4
sum_of_sums([1, 2, 3, 4, 5]) == 35
