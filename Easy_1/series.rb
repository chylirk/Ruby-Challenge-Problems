# Write a program that will take a string 
# of digits and give you all the possible 
# consecutive number series of length n in that string.

# nouns: string, digits, consecutive numbers, length
# verbs: slice

# series object, slices method

# slices method
# p:
#    i: integer
#    o: array of arrays - consecutive numbers of length (integer)
# e:
#    '01234' => '012', '123', '234'
# d: string => integer => array
# a: slice chunks of the input string-to-array with length n
# c:

require 'pry'

class Series
  attr_reader :series

  def initialize(s)
    @series = s.chars.map(&:to_i)
  end

  def slices(n)
    validate_input(n)
    
    result = []
    0.upto(self.series.size) do |idx|
      # binding.pry
      result << self.series[idx..idx+(n-1)] unless idx+(n-1) >= self.series.size
    end
    result
  end

  def validate_input(size)
    fail(ArgumentError, "Too big") if size > self.series.size
  end
end

series1 = Series.new('01234')
puts series1.series
p series1.slices(3)
p series1.slices(4)