# frozen_string_literal: true

require 'pry'

class OCR
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

  def translate
    result = []
    word_one = []
    if text.split("\n")[0][0..1] == "  "
      word_one << ""
    else
      word_one << text.split("\n")[0][0..1]
    end
    word_one << text.split("\n")[1][0..2]
    word_one << text.split("\n")[2][0..2]
    result << (word_one.join("\n") + "\n")

    counter = 1
    loop do
      break if counter == word_count
      word = []
      if text.split("\n")[0][3 * counter..3 * counter + 2] == "   "
        word << ""
      else
        word << text.split("\n")[0][3 * counter..3 * counter + 1]
      end
      word << text.split("\n")[1][3 * counter..3 * counter + 2].rstrip
      word << text.split("\n")[2][3 * counter..3 * counter + 2].rstrip
      result << (word.join("\n") + "\n")
      counter += 1
    end
    result
  end

  def convert
    if text.split("\n")[0].size <= 2
      NUM_HASH.keys.include?(text) ? NUM_HASH[text] : '?'
    else
      translate.map do |word|
        # binding.pry
        NUM_HASH.keys.include?(word) ? NUM_HASH[word] : '?'
      end.join
    end
  end
end

# if text.split("\n")[0].size == 5
#   word_one = []
#       if text.split("\n")[0][0..1] == " "
#   word_1 = text.split("\n")[0][0..1] + text.split("\n")[1][0..2] + text.split("\n")[2][0..2]

    text = <<-NUMBER.chomp
    _  _     _  _  _  _  _  _
  | _| _||_||_ |_   ||_||_|| |
  ||_  _|  | _||_|  ||_| _||_|

    NUMBER

puts OCR.new(text).convert