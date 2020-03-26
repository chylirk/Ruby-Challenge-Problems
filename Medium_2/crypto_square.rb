# frozen_string_literal: true

require 'pry'

class Crypto
  attr_reader :text

  def initialize(text)
    @text = text
  end

  def normalize_plaintext
    text.scan(/\w/).join.downcase
  end

  def size
    (normalize_plaintext.size**0.5).ceil
  end

  def plaintext_segments
    (0..size).each_with_object([]) do |idx, arr|
      # binding.pry
      if idx * size < normalize_plaintext.size
        arr << normalize_plaintext[(idx * size)...(idx + 1) * size]
      end
    end
  end

  def cipher
    word_size = plaintext_segments[0].size

    (0...word_size).each_with_object([]) do |idx, arr|
      result = ''
      plaintext_segments.each do |word|
        # binding.pry
        result += (word[idx].nil? ? ' ' : word[idx])
      end
      arr << result
    end.map(&:strip)
  end

  def ciphertext
    cipher.join('')
  end

  def normalize_ciphertext
    cipher.join(' ')
  end
end

# crypto = Crypto.new('Never vex thine heart with idle woes')
# expected = %w(neverv exthin eheart withid lewoes)
# p crypto.plaintext_segments
# p crypto.size
# p crypto.ciphertext
# p crypto.normalize_ciphertext

# crypto = Crypto.new('Madness, and then illumination.')
# expected = 'msemo aanin dnin ndla etlt shui'
# puts crypto.plaintext_segments
# p crypto.normalize_ciphertext
