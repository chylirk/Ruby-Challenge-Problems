# i: two dna strands
# o: Hamming disC

class DNA
  attr_reader :target_strand

  def initialize(strand)
    @target_strand = strand
  end

  def hamming_distance(strand)
    result = 0
    
    strands = [self.target_strand, strand].sort { |a, b| a.size <=> b.size }
    
    strands[0].chars.each_with_index do |char, idx|
      result += 1 if char != strands[1][idx]
    end
    result
  end
end
