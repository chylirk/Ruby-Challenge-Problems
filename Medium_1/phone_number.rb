require 'pry'

class PhoneNumber
  DEFAULT = '0000000000'

  attr_reader :num, :num_clean

  def initialize(num)
    @num = num
    @num_clean = num.gsub(/\W/,'')
  end

  def letters?
    self.num.scan(/[A-Za-z]/).size > 0
  end

  def too_small?
    self.num_clean.size < 10
  end

  def too_big?
    # binding.pry
    return self.num_clean.size > 10 unless (self.num_clean.size == 11 && self.num_clean[0] == '1')
    return @num_clean[0] != '1'
  end

  def number
    # binding.pry
    return DEFAULT if (letters? || too_small? || too_big?)
    @num_clean[-10..-1]
  end

  def area_code
    number[0..2]
  end

  def to_s
    "(#{area_code}) #{number[3..5]}-#{number[6..9]}"
  end
end

# puts PhoneNumber.new('19876543210').pretty_print