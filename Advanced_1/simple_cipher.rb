# frozen_string_literal: true

require 'pry'

class Cipher
  ALPHABET = [*('a'..'z')].freeze
  LETTER_COUNT = ALPHABET.size
  MIN_ORD = ALPHABET[0].ord
  KEY_SIZE = 100

  attr_reader :key

  def initialize(key = nil)
    raise(ArgumentError) if invalid?(key)

    @key = (key.nil? ? ALPHABET.sample(KEY_SIZE).join : key)
  end

  def invalid?(str)
    /\W|[A-Z]|\d/.match(str) || str == ''
  end

  def encode(str)
    code(str, :+)
  end

  def decode(str)
    code(str, :-)
  end

  def norm(chr)
    chr.ord - MIN_ORD
  end

  def code(str, oper)
    str.chars
       .map
       .with_index do |chr, idx|
      ([norm(chr), norm(key[idx])].reduce(oper) % LETTER_COUNT + MIN_ORD).chr
    end
       .join
  end
end

# cipher = Cipher.new('dddddddddddddddd')
# puts cipher.encode('iamapandabear') == 'ldpdsdqgdehdu'
# puts cipher.decode('ldpdsdqgdehdu') == 'iamapandabear'

# key = 'abcdefghij'
# cipher = Cipher.new(key)
# plaintext = 'zzzzzzzzzz'
# ciphertext = 'zabcdefghi'
# puts cipher.encode(plaintext) == ciphertext

# plaintext = 'abcdefghij'
# puts plaintext == cipher.decode(cipher.encode(plaintext))

# @cipher = Cipher.new
# plaintext = 'abcdefghij'
# puts plaintext
# puts @cipher.key
# puts @cipher.encode(plaintext)
# puts @cipher.decode(@cipher.encode(plaintext)) # == 'abcdefghij'
