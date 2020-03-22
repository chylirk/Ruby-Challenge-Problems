# module RomanEnumerable
#   def to_roman
#     'I'
#   end
# end

# Integer.include RomanEnumerable

# i: integer
# o: roman numberals
# e: 2 => 'II', see test suite
# d: integer => array? => string
# a:
#    modulo by powers of ten to get the different places
#    translate each place into roman numerals
#    concatenate
#

module RomanEnumerable
  def to_roman

    int = self

    rom_num = { 
      1 => 'I', 2 => 'II', 3 => 'III', 4 => 'IV', 5 => 'V', 
      6 => 'VI', 7 => 'VII', 8 => 'VIII', 9 => 'IX', 10 => 'X', 
      20 => 'XX', 30 => 'XXX', 40 => 'XL', 50 => 'L', 60 => 'LX', 
      70 => 'LXX', 80 => 'LXXX', 90 => 'XC', 100 => 'C', 200 => 'CC', 
      300 => 'CCC', 400 => 'CD', 500 => 'D', 600 => 'DC', 700 => 'DCC', 
      800 => 'DCCC', 900 => 'CM', 1000 => 'M', 2000 => 'MM', 3000 => 'MMM', 
      0 => ''
    }

    thousands = (int / 1000) * 1000
    hundreds = ((int % 1000) / 100) * 100
    tens = ((int % 100) / 10) * 10
    ones = (int % 10) / 1

    rom_num[thousands] + rom_num[hundreds] + rom_num[tens] + rom_num[ones]
  end
end

Integer.include RomanEnumerable

# puts to_roman(2008)