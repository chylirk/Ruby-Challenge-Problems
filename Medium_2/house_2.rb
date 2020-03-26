# frozen_string_literal: true

require 'pry'

class House
  def self.retrieve_text
    House.new.send(:pieces)
  end

  def self.verse(int)
    "#{retrieve_text[-int][1]} #{retrieve_text[-int + 1][0]}"
  end

  def self.stanza(int)
    result = ["This is #{retrieve_text[-int][0]}"]
    (2..int).reverse_each do |idx|
      result << verse(idx)
    end
    result.join("\n") + '.'
  end

  def self.recite
    result = ["This is #{retrieve_text[-1][0]}."]
    (2..12).each do |int|
      result << stanza(int)
    end
    result.join("\n\n") + "\n"
  end

  private

  def pieces
    [
      ['the horse and the hound and the horn', 'that belonged to'],
      ['the farmer sowing his corn', 'that kept'],
      ['the rooster that crowed in the morn', 'that woke'],
      ['the priest all shaven and shorn', 'that married'],
      ['the man all tattered and torn', 'that kissed'],
      ['the maiden all forlorn', 'that milked'],
      ['the cow with the crumpled horn', 'that tossed'],
      ['the dog', 'that worried'],
      ['the cat', 'that killed'],
      ['the rat', 'that ate'],
      ['the malt', 'that lay in'],
      ['the house that Jack built']
    ]
  end
end
