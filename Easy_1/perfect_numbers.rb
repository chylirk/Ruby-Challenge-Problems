# frozen_string_literal: true

# method for getting divisors (except self)
# method for returning string value based on sum of divisors
# raises a RuntimeError if the number is negative

# divisors
#    initialize result set of [1]
#    loop through the integers between 2 and (target / 2)
#        if modulo returns 0
#            add the integer and (target / integer) to a result set
#    sum the result set

# puts divisors(6)
# puts divisors(28)

class PerfectNumber
  def self.classify(int)
    raise RuntimeError if int.negative?

    asum = [*(1...int)].select { |val| (int % val).zero? }.reduce(&:+)

    if asum > int then 'abundant'
    elsif asum < int then 'deficient'
    else 'perfect'
    end
  end
end
