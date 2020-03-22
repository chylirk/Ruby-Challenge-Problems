class Scrabble
  attr_accessor :word

  VALUES = {
    %w(a e i o u l n r s t) => 1,
    %w(d g) => 2,
    %w(b c m p) => 3,
    %w(f h v w y) => 4,
    %w(k) => 5,
    %w(j x) => 8,
    %w(q z) => 10,
  }

  def initialize(word)
    word == nil ? @word = '' : @word = word.downcase
  end

  def score
    score = 0
    self.word.chars.each do |char|
      VALUES.keys.each do |key_arr|
        score += VALUES[key_arr] if key_arr.include?(char)
      end
    end
    score
  end

  def self.score(word)
    Scrabble.new(word).score
  end
end