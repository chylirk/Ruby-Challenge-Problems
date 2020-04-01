# frozen_string_literal: true

require 'pry'

class SingleOCR
  NUM_HASH = {
    " _\n| |\n|_|\n" => '0',
    "\n  |\n  |\n" => '1',
    " _\n _|\n|_\n" => '2',
    " _\n _|\n _|\n" => '3',
    "\n|_|\n  |\n" => '4',
    " _\n|_\n _|\n" => '5',
    " _\n|_\n|_|\n" => '6',
    " _\n  |\n  |\n" => '7',
    " _\n|_|\n|_|\n" => '8',
    " _\n|_|\n _|\n" => '9'
  }.freeze

  attr_reader :text, :word_count

  def initialize(text)
    @text = text
    @word_count = (text.split("\n")[0].size + 1) / 3
  end

  def word_one
    word_one = []
    lead_char = text.split("\n")[0][0..1]
    word_one << (lead_char == '  ' ? '' : lead_char)
    [1, 2].each { |v| word_one << text.split("\n")[v][0..2] }
    word_one.join("\n") + "\n"
  end

  def line_parse(line, counter)
    text.split("\n")[line][3 * counter..3 * counter + 2]
  end

  def word_parse(counter)
    word = []
    chunk = text.split("\n")[0][3 * counter..3 * counter + 1]
    word << (line_parse(0, counter) == '   ' ? '' : chunk)
    [1, 2].each { |v| word << line_parse(v, counter).rstrip }
    word
  end

  def translate
    result = [word_one]
    (1..word_count - 1).each do |counter|
      result << (word_parse(counter).join("\n") + "\n")
    end
    result
  end

  def convert
    if text.split("\n")[0].size <= 2
      NUM_HASH.key?(text) ? NUM_HASH[text] : '?'
    else
      translate.map do |word|
        # binding.pry
        NUM_HASH.key?(word) ? NUM_HASH[word] : '?'
      end.join
    end
  end
end

# if text.split("\n")[0].size == 5
#   word_one = []
#       if text.split("\n")[0][0..1] == " "
#   word_1 = text.split("\n")[0][0..1]
#   + text.split("\n")[1][0..2]
#   + text.split("\n")[2][0..2]

class OCR
  attr_reader :text_arr

  def initialize(text)
    @text_arr = text.split("\n\n")
  end

  def convert
    @text_arr.map { |num| SingleOCR.new(num).convert }.join(',')
  end
end

# text = <<-NUMBER.chomp
#     _  _
#   | _| _|
#   ||_  _|

#     _  _
# |_||_ |_
#   | _||_|

#  _  _  _
#   ||_||_|
#   ||_| _|

# NUMBER

# puts OCR.new(text).convert
