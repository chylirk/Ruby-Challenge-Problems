AMINO_ACIDS = {
  'Methionine' => ['AUG'],
  'Phenylalanine' => ['UUU', 'UUC'],
  'Leucine' => ['UUA', 'UUG'],
  'Serine' => ['UCU', 'UCC', 'UCA', 'UCG'],
  'Tyrosine' => ['UAU', 'UAC'],
  'Cysteine' => ['UGU', 'UGC'],
  'Tryptophan' => ['UGG'],
  'STOP' => ['UAA', 'UAG', 'UGA']
}

class InvalidCodonError < StandardError; end

class Translation
  def self.of_codon(str)
    AMINO_ACIDS.select { |k, v| v.include?(str) }.keys.first
  end

  def self.of_rna(str)
    result = []
    idx = 0
    loop do
      codon = str[idx..idx+2]
      amino_acid = self.of_codon(codon)

      break if amino_acid == 'STOP' || ixdped+2 >= str.size

      raise InvalidCodonError if !AMINO_ACIDS.values.flatten.include?(codon)

      result << amino_acid
      idx += 3
    end
    result
  end
end
