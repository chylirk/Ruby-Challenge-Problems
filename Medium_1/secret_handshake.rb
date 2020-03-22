# binary conversion method
#    i: decimal integer
#    o: binary representation
#    e: dec_to_bin(9) == 1001
#       dec_to_bin(31) == 11111
#    d: integer => integer
#    a: modulo int by 2
#       store the result in an array
#       modulo the result by 2
#       store the result in an array
#       repeat until the result equals 0
#       reverse the array to get the binary representation

# def dec_to_bin_array(int)
#   result = []

#   quotient = int

#   loop do
#     remainder = quotient % 2
#     result << remainder

#     quotient = quotient / 2
#     break if quotient == 0
#   end

#   result.map.with_index { |v, idx| v * 10 ** idx }.reverse.select { |v| v > 0 }
# end

# puts dec_to_bin_array(9) #== [1000, 1]
# puts dec_to_bin_array(31) #== [10000, 1000, 100, 10, 1]

# binary to string method
#    i: binary integer
#    o: array of strings
#    e: bin_array_to_string([1000, 1]) == ["wink", "jump"]
#       bin_array_to_string([10000, 1000, 1]) == ["jump", "wink"]
#    a: map elements of array (except 10000)
#    c:

# def bin_array_to_string(arr)
#   code = {
#     1 => 'wink',
#     10 => 'double blink',
#     100 => 'close your eyes',
#     1000 => 'jump',
#   }

#   if arr.include?(10000)
#     arr.reverse
#     arr.delete(10000)
#   end

#   arr.map { |v| code[v] }
# end

# p bin_array_to_string(dec_to_bin_array(9))
# p bin_array_to_string(dec_to_bin_array(31))

# require 'pry'

class SecretHandshake
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def commands
    return [] if @value.to_i.to_s != @value.to_s
    # puts dec_to_bin_array(self.value.to_i)
    # puts bin_array_to_string([10, 1])
    bin_array_to_string(dec_to_bin_array(self.value.to_i))
  end


  def dec_to_bin_array(int)
    result = []

    quotient = int

    loop do
      remainder = quotient % 2
      result << remainder

      quotient = quotient / 2
      break if quotient == 0
    end

    result.map.with_index { |v, idx| v * 10 ** idx }.select { |v| v > 0 }
  end

  def bin_array_to_string(arr)
    code = {
      1 => 'wink',
      10 => 'double blink',
      100 => 'close your eyes',
      1000 => 'jump',
    }

    if arr.include?(10000)
      arr.reverse!
      arr.delete(10000)
    end

    arr.map { |v| code[v] }
  end
end
