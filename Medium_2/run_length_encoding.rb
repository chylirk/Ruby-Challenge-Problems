# frozen_string_literal: true

require 'pry'

# method - encode
# i: str
# o: str - integers with count followed by char
# e: see test suite
# d: str => array? => string
# a: loop over elements in the array
#    if the character does not match the previous charater
#        and does match the next character
#      then add it to an output array
#    if the character matches the previous character
#      then add a '1' to the output array

# method - decode
# i: str of integers and letters
# o: string of letters

class RunLengthEncoding
  def self.digitize(input)
    input.chars.map.with_index do |char, idx|
      input[idx] == input[idx + 1] ? 1 : char
    end
  end

  def self.condition_one(val, input, idx)
    val == 1 && digitize(input)[idx + 1] == 1
  end

  def self.condition_two(val, input, idx)
    val == 1 && digitize(input)[idx + 1] != 1
  end

  def self.encipher(input)
    incrementer = 0
    digitize(input).each_with_object([]).with_index do |(val, arr), idx|
      arr << val if val != 1
      if condition_one(val, input, idx)
        incrementer += 1
      elsif condition_two(val, input, idx)
        arr << (incrementer + 2).to_s
        incrementer = 0
      end
    end
  end

  def self.encode(input)
    encipher(input).join
  end

  def self.int?(str)
    str.to_i.to_s == str
  end

  def self.characters(input)
    input.chars
  end

  def self.decipher(input)
    arr = [1, '']
    characters(input).each_with_object([]).with_index do |(char, result), idx|
      if int?(char)
        arr[1] += char
        arr[0] = arr[1].to_i unless int?(input.chars[idx + 1])
      else
        result << (char * arr[0])
        arr = [1, '']
      end
    end
  end

  def self.decode(input)
    decipher(input).join
  end
end

# input = 'WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB'
# p RunLengthEncoding.encode(input)
# p RunLengthEncoding.decode('12WB12W3B24WB')
