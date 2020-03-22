# method for getting divisors (except self)
# method for returning string value based on sum of divisors
# raises a RuntimeError if the number is negative

# divisors
#    initialize result set of [1]
#    loop through the integers between 2 and (target / 2)
#        if modulo returns 0, add the integer and (target / integer) to a result set
#    sum the result set 

def divisors(int)
  result_set = [1]
  (2..(int/2)).to_a.each do |val|
    if int % val == 0
      result_set << val
      result_set << (int / val)
    end
  end
  result_set.uniq.reduce(&:+)
end

puts divisors(6)
puts divisors(28)

class PerfectNumber
  attr_reader :num

  def initialize(num)
    raise RuntimeError if num < 0
    @num = num
  end

  def aliquot_sum
    divisors(self.num)
  end

  def classify
    case aliquot_sum
    when > self.num then 'abundant'
    when < self.num then 'deficient'
    else 'perfect'
    end
  end
end
