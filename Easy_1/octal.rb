# octal => decimal conversion
#
# i: octal string
# o: decimal output
# e:
# 233
# 2 * 8^2 + 3 * 8^1 + 3 * 8^0
# 2*64 + 3*8 + 3*1
# 128 + 24 + 3

require 'pry'

class Octal
  attr_reader :oct_string

  BASE = 8

  def initialize(n)
    @oct_string = n
  end

  def to_decimal
    return 0 if invalid_string

    answer = 0
    oct_string.to_i
              .digits
              .each_with_index do |int, idx|
      answer += (int * BASE ** idx)
    end
    answer
  end

  def invalid_string
    oct_string =~ /\D|[8-9]/
  end
end

# puts to_dec("1")
# puts to_dec("10")
# puts to_dec("17")
# puts to_dec("11")
# puts to_dec("130")
# puts to_dec("2047")