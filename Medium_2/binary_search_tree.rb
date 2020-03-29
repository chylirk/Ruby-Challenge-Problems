# frozen_string_literal: true

require 'pry'

class Bst
  attr_reader :data
  attr_accessor :left, :right

  def initialize(data, left: nil, right: nil)
    @data = data
    @left = left if left
    @right = right if right
  end

  def insert(datum)
    # binding.pry
    if datum <= data
      left.nil? ? self.left = Bst.new(datum) : left.insert(datum)
    else
      right.nil? ? self.right = Bst.new(datum) : right.insert(datum)
    end
  end

  def each
    return enum_for(:each) unless block_given?

    left.each { |var| yield(var) } if self&.left
    yield(data)
    right.each { |var| yield(var) } if self&.right
  end
end

# four = Bst.new 4
# four.insert 2
# four.insert 6
# four.insert 1
# four.insert 3
# four.insert 7
# four.insert 5
# puts four.smallest
# puts four.largest
# puts 4 == four.data
# puts 2 == four.left.data
# puts 1 == four.left.left.data
# puts 3 == four.left.right.data
# puts 6 == four.right.data
# puts 5 == four.right.left.data
# puts 7 == four.right.right.data

# puts four.data
# puts four.left.data
# puts four.left.left.data
# puts four.left.left.left.data
