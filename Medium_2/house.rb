require 'pry'

class House
  def self.retrieve_text
    House.new.send(:pieces)
  end

  def self.verse(int)
    "#{self.retrieve_text[-int][1]} #{self.retrieve_text[-int+1][0]}"
  end

  def self.stanza(int)
    result = ["This is #{self.retrieve_text[-int][0]}"]
    (2..int).to_a.reverse.each do |idx|
      result << verse(idx)
    end
    result.join("\n") + "."
  end


  def self.recite
    text = self.retrieve_text
    result = <<-RHYME
This is #{text[-1][0]}.

#{stanza(2)}

#{stanza(3)}

#{stanza(4)}

#{stanza(5)}

#{stanza(6)}

#{stanza(7)}

#{stanza(8)}

#{stanza(9)}

#{stanza(10)}

#{stanza(11)}

#{stanza(12)}
RHYME
    result
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

puts House.recite