# i: an integer (the up-to number)
#    zero or more integers (divisors, default to 3 or 5)
# o: integer: sum of multiples
# e: test suite
# d: integer (up to), array (divisors) => integers => integer
# a:
#
# method 1: find all the multiples of a number up to another number
#        i: two integers (up-to # and a step)
#        o: array of multiples
#        e: multiples(20, 5) == [5, 10, 15]
#           multiples(20, 3) == [3, 6, 9, 12, 15, 18]
#        d: integer => array
#        a: range = (a..b)
#           range.step(multiple)
require 'pry'

def multiples(target, multiple)
  (0...target).step(multiple).to_a
end

puts multiples(20, 5) == [0, 5, 10, 15]
puts multiples(20, 3) == [0, 3, 6, 9, 12, 15, 18]

# method 2: find all the multiples of two or more numbers up to a target number
#        a: repeat the multiples method with each multiple 
#        a: call .unique on the combined sets
#        3: multi_multiples(20, 3, 5) == [3, 5, 6, 9, 12, 15, 18]

def sum_multi_multiples(target, *multiple)
  result = []
  multiple.each do |mult|
    result += multiples(target, mult)
  end
  result.uniq.sort.reduce(&:+)
end

p sum_multi_multiples(20, 3, 5) == 78

class SumOfMultiples
  attr_reader :target, :multiples

  def initialize(*multiples)
    @multiples = multiples
  end

  def to(upto)
    # binding.pry
    sum_multi_multiples(upto, @multiples)
  end

  def multiples(target, multiple)
    (0...target).step(multiple).to_a
  end

  def sum_multi_multiples(target, multiple)
    result = []
    # binding.pry
    multiple.each do |mult|
      result += multiples(target, mult)
    end
    result.uniq.sort.reduce(&:+)
  end

  def self.to(upto)
    sum_multi_multiples(upto, 3, 5)
  end
end

class SumOfMultiples
  attr_reader :target, :multiples

  def initialize(*multiples)
    @multiples = multiples
  end

  def sum_multi_multiples(target, multiple)
    result = []
    # binding.pry
    multiple.each do |mult|
      result += (0...target).step(mult).to_a
    end
    result.uniq.sort.reduce(&:+)
  end

  def to(upto)
    sum_multi_multiples(upto, @multiples)
  end

  def self.to(upto)
    SumOfMultiples.new(3, 5).to(upto)
  end
end

