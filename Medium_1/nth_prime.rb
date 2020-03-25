# frozen_string_literal: true

# def prime?(int)
#   (2..int**0.5).to_a.select do |val|
#     int % val == 0
#   end.empty?
# end

# puts prime?(2)
# puts prime?(5)
# puts !prime?(6)
# puts prime?(13)
# puts !prime?(24)
# puts prime?(104743)
# puts !prime?(104744)

# def nth_prime(n)
#   primes = []

#   start = 2
#   loop do
#     break if primes.size == n
#     primes << start if prime?(start)
#     start += 1
#   end

#   primes.last
# end

# puts nth_prime(1) == 2
# puts nth_prime(2) == 3
# puts nth_prime(6) == 13
# puts nth_prime(10001) == 104743

class Prime
  def self.prime?(int)
    (2..int**0.5).to_a.none? { |val| (int % val).zero? }
  end

  def self.nth(nth)
    raise ArgumentError if nth < 1

    prime_count = 0
    current = 2
    loop do
      prime_count += 1 if prime?(current)
      return current if prime_count == nth

      current += 1
    end
  end
end
