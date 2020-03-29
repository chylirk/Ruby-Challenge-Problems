# frozen_string_literal: true

require 'pry'

# i: letter
# o: string of letters + spaces
# e: make_line('A') == 'A'
#    make_line('B') == 'B B'
#    make_line('C') == 'C  C'
# d: String => String
# a:
#    call ord on string
#    subtract 65 from the .ord
#    add that much space between the characters
# 'A'.ord == 65

# ('A'..'Z').each do |char|
#   puts make_line(char)
# end

class Diamond
  def self.make_line(char)
    return char if char == 'A'

    # binding.pry
    char + ' ' * (2 * (char.ord.to_i - 65) - 1) + char
  end

  def self.make_diamond(char)
    result = []
    ('A'..char).each do |let|
      result << make_line(let).center(2 * (char.ord.to_i - 65) + 1)
    end
    (result + result.reverse[1..-1]).join("\n") + "\n"
  end
end
# p Diamond.make_diamond('A')
# p Diamond.make_diamond('C')
