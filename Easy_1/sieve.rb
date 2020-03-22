# nouns:
#    Sieve
# verb:
#    primes
require 'pry'

puts $LOADED_FEATURES.grep(/\/pry\.rb/)

class Sieve
  def initialize(n)
    range = (2..n).to_a
    @num_hash = {}
    range.each do |int|
      @num_hash[int] = 'Unmarked'
    end
  end

  def mark_multiples(n)
    @num_hash.keys.each do |int|
      @num_hash[int] = 'Marked' if (int != n && int % n == 0)
    end
  end

  def primes
    @num_hash.each do |k, v|
      # binding.pry
      mark_multiples(k) if v == 'Unmarked'
    end
    @num_hash.select { |k, v| v == 'Unmarked' }.keys
  end
end

sv = Sieve.new(10)
p sv.primes