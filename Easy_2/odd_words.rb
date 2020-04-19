# frozen_string_literal: true

require 'pry'

# class OddWords
#   def self.translate(str)
#     str.split.map.with_index do |val, idx|
#       if idx.even?
#         val
#       else
#         val.reverse
#       end
#     end.join(' ')
#   end
# end

class OddWords
  MARKERS = [' ', '.'].freeze

  def self.reset_stack(stack)
    stack.reverse_each { |val| puts val }
    []
  end

  def self.valid?(str)
    str.scan(/[?&%*@#$^]/).empty?
  end

  def self.translate(str)
    raise(ArgumentError) unless valid?(str)

    even_word = true
    stack = []
    str.chars.each_with_index do |char, idx|
      next_char = str.chars[idx + 1]
      if MARKERS.include?(char)
        stack = reset_stack(stack) unless even_word
        unless MARKERS.include?(next_char)
          even_word = !even_word
          puts char
        end
      elsif even_word
        puts char
      else
        stack << char
      end
    end
    reset_stack(stack)
  end
end

# OddWords.translate("whats the matter with kansas")
# puts ''
# puts ''
# OddWords.translate("whats.")
# puts ''
# puts ''
# OddWords.translate("whats the.")
# str = 'whats the matter with kansas.'
# puts ''
# puts ''
# OddWords.translate(str)

# str = 'hello word .'
# OddWords.translate(str)
