# i: integer
# o: integer with every 2nd digit doubled
#        if the doubling makes it greater than 10, subtract 9
# def addends(int)
#   doubled = int.digits.map.with_index do |val, idx|
#     idx % 2 == 1 ? val * 2 : val
#   end

#   doubled.map { |v| v > 9 ? v - 9 : v }.reverse
# end

# p addends(12121)
# p addends(8631)

# def checksum(int)
#   addends(int).reduce(&:+)
# end

# p checksum(4913)
# p checksum(201_773)

# def valid?(int)
#   checksum(int) % 10 == 0
# end

# p !valid?(738)
# p valid?(8_739_567)

# def create(int)
#   answer = nil
#   check = 0
#   loop do
#     answer = (int.to_s + check.to_s).to_i
#     break if valid?(answer)
#     raise StandardError if check > 9
#     check += 1
#   end
#   answer
# end

# p create(123)
# p create(873_956)

class Luhn
  attr_accessor :num

  def initialize(int)
    @num = int
  end

  def addends
    doubled = self.num.digits.map.with_index do |val, idx|
      idx % 2 == 1 ? val * 2 : val
    end

    doubled.map { |v| v > 9 ? v - 9 : v }.reverse
  end

  def checksum
    addends(num).reduce(&:+)
  end

  def valid?
    checksum(num) % 10 == 0
  end

  def self.create(int)
    answer = nil
    check = 0
    loop do
      answer = (int.to_s + check.to_s).to_i
      break if valid?(answer)
      raise StandardError if check > 9
      check += 1
    end
    answer
  end
end