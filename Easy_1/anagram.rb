class Anagram
  attr_reader :target_word, :target_letters
  def initialize(target)
    @target_word = target.downcase
    @target_letters = letters(target)
  end

  def match(array)
    array.select do |str|
      anagram?(str)
    end
  end

  def anagram?(word)
    letters(word) == self.target_letters unless word.downcase == self.target_word
  end

  def letters(word)
    word.downcase.chars.sort
  end
end