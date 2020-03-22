class Phrase
  attr_accessor :string

  def initialize(str)
    @string = process(str).downcase
  end

  def word_count
    self.string.split.each_with_object(Hash.new(0)) { |obj, hsh| hsh[obj] += 1 }
  end

  private

  def process(str)
    strip_punctuation(strip_newline(strip_quotations(str)))
  end

  def strip_punctuation(str)
    str.gsub(/[,.:!&@$%^]/, ' ')
  end

  def strip_newline(str)
    str.gsub(/\\n/, ' ')
  end

  def strip_quotations(str)
    str.gsub(/( '|' )/, ' ')
  end
end

phrase = Phrase.new("Joe can't tell between 'large' and large.")

puts phrase.word_count