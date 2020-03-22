# if the word starts with a vowel, add 'ay'
# if the first vowel is 'u' and is followed by a 'vowel' 
# and the last consonant before the 'u' is 'q', then add the 'u' to the end

# if the word starts with x followed by a consonant, just add 'ay'

# if the word starts with a constant then a vowel, move the consonant to the end, add 'ay'
# recurse?

# def vowel_pig_latin(str)
#   if str[-1] == 'a'
#     str + 'y'
#   else
#     str+ 'ay'
#   end
# end

# puts vowel_pig_latin('apple')
# puts vowel_pig_latin('ear')

class PigLatin
  VOWELS = %w(a e i o u y)

  def self.translate(str)
    str.split.map { |str| translate_tree(str) }.join(' ')
  end

  def self.xconstonant_detector(str)
    str[0] == 'x' && !VOWELS.include?(str[1])
  end

  def self.yvowel_detector(str)
    str[0] == 'y' && VOWELS.include?(str[1])
  end

  def self.qu_detector(str)
    qu_first_consontant = nil

    u_count = 0

    str.chars.each_with_index do |char, idx|
      if (char == 'u') && (str.chars[idx-1] == 'q') && (u_count == 0)
        qu_first_consontant = true
      end
    end
    qu_first_consontant
  end

  def self.translate_tree(str)
    if qu_detector(str)
      translate_consonants(move_qu(str))
    elsif yvowel_detector(str)
      translate_vowel(rotate_one(str))
    elsif xconstonant_detector(str)
      translate_vowel(str)
    else
      translate_consonants(str)
    end
  end

  def self.move_qu(str)
    answer = str
    loop do
      answer = rotate_one(answer)
      break if answer[-1] == 'u'
    end
    answer
  end

  def self.translate_consonants(str)
    if VOWELS.include?(str[0])
      translate_vowel(str)
    else
      translate_consonants(rotate_one(str))
    end
  end

  def self.translate_vowel(str)
    str + 'ay'
  end

  def self.rotate_one(str)
    str[1..-1] + str[0]
  end
end