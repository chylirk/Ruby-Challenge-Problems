# frozen_string_literal: true

require 'pry'

# methods: sum, product, pythagorean?, where(max_factor: , min_factor: , sum: )
# data structure: array

# method 1 - product
#    arr.reduce(&:*)

# method 2- pythagorean?
# i: 3 integers
# o: boolean
# e: (3, 4, 5) == true
#    (1, 2, 3) == false
#    (5, 6, 7) == true
#    (6, 7, 8) == false
# d: array => boolean
# a: map each element with it's square, check if last equals sum of first two

# def pythagorean?(*factors)
#   squared = factors.map { |v| v**2 }
#   squared[-1] == squared[0..-2].sum
# end

# puts pythagorean?(3, 4, 5) == true
# puts pythagorean?(20, 21, 29) == true
# puts pythagorean?(6, 7, 8) == false
# puts pythagorean?(5, 6, 7) == false

# method 3 - where(max_factor: , min_factor: , sum: )
# i: max_factor, min_factor, sum
# o: array of arrays, each array being a pythagorean triplet
# e: Triplet.where(max_factor: 10) == [[3, 4, 5], [6, 8, 10]]
# e: Triplet.where(min_factor: 11, max_factor: 20) == [[12, 16, 20]]
# e: Triplet.where(sum: 180, max_factor 100) == [[]]
# a:
#    when max_factor is given but not min_factor or sum
#        min_factor defaults to 1
#        sum defaults to nil (ignore)
#    square the max_factor
#    create two arrays
#        one for numbers from one to half of max
#        another for ints from max to half to max
#    zip the two arrays together
#    select the arrays
#        where the sum of the squared elements is the squared max_factor
# c:
#    (max_factor: 10, min_factor = 1)
#        target = max_factor ** 2
#        arr1 = [1, 2, 3, 4, 5]
#        arr2 = [5, 6, 7, 8, 9]
#        arr = arr1.zip(arr2)
#        arr.select { |subarr| (subarr[0]**2 + subarr[1]**2) == target}
#    end
#    create Triplet objects with the result arrays appending the max_factor

class Triplet
  attr_reader :factors

  def initialize(*factors)
    @factors = factors.sort
  end

  def pythagorean?
    factors[0]**2 + factors[1]**2 == factors[2]**2
  end

  def sum
    factors.sum
  end

  def product
    factors.reduce(&:*)
  end

  def self.uniq_combinations(arr)
    arr.product(arr).map!(&:sort).uniq
  end

  def self.sum_of_squares(arr)
    arr[0]**2 + arr[1]**2
  end

  def self.root_sum_of_squares(arr)
    (sum_of_squares(arr)**0.5).to_i
  end

  def self.factors(min: 1, max: nil, sum: nil)
    minmax_arr = (min..max).to_a
    targets = minmax_arr.map { |v| v**2 }
    result = uniq_combinations(minmax_arr)
             .map! { |arr| arr << root_sum_of_squares(arr) }
             .select { |arr| targets.include?(sum_of_squares(arr)) }
    sum.nil? ? result : result.select { |arr| arr.sum == sum }
  end

  def self.where(min_factor: 1, max_factor: nil, sum: nil)
    factors(min: min_factor, max: max_factor, sum: sum).map do |arr|
      Triplet.new(arr[0], arr[1], arr[2])
    end
  end
end

# p Triplet.where(max_factor: 10).map(&:product).sort
# p Triplet.where(min_factor: 11, max_factor: 20).map(&:product)
# p Triplet.where(sum: 180, max_factor: 100).map(&:product).sort
