# frozen_string_literal: true

require 'pry'

class Palindromes
  attr_accessor :bounds, :palindromes

  def initialize(max_factor: 10, min_factor: 1)
    @bounds = (min_factor..max_factor).to_a
    @palindromes = Hash.new([])
  end

  def palindrome?(int)
    int == int.digits.join.to_i
  end

  def generate_products
    bounds.product(bounds)
  end

  def generate
    generate_products.each do |arr|
      key = arr.reduce(&:*)
      next unless palindrome?(key)

      palindromes[key] = [arr.sort] if palindromes[key].empty?

      palindromes[key].append(arr.sort)
    end
  end

  def largest
    Palindrome.new(@palindromes.select { |k, _| k == @palindromes.keys.max })
  end

  def smallest
    Palindrome.new(@palindromes.select { |k, _| k == @palindromes.keys.min })
  end
end

class Palindrome
  attr_accessor :value, :factors

  def initialize(pal)
    # binding.pry
    @value = pal.keys.first
    @factors = pal.values[0].uniq
  end
end

# palindrome = Palindromes.new(max_factor: 9)
# palindrome.generate
# # p palindrome.palindromes
# largest = palindrome.largest
# smallest = palindrome.smallest
# p largest.value
# p largest.factors
