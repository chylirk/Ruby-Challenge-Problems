require 'pry'
# pick the best poker hand
# detect the value of poker hands
# detect different hands from a set of cards
# apply a series of checks for each type of poker hand
# ex. straight_flush?
#     four_of_a_kind?

# straight_flush?
# i: array of strings
# o: boolean plus some other value contingent on the boolean
# e: straight_flush?(JC TC 9C 8C 7C) == 11
#    straight_flush?(JC 10C 9C 8C 6C) == false
#    straight_flush?(AC 2C 3C 4C 5C) == 5
#    straight_flush?(AC KC QC JC 10C) == 14
# d: string => array of arrays => string or boolean
# a: get the first value of each string (value)
#    get the second value of each string (suit)
#    check if all the suits are the same
#    check if the # of distinct values is five
#    check whether the max value minus the min value is 4
#    need to account for face cards (J: 11, Q: 12, K: 13, A: 14)
#    ace can be 1 or 14 (i.e. can form a straight from ace to five)

class Hand
  FACE_TO_VAL = {
    'T' => 10,
    'J' => 11,
    'Q' => 12,
    'K' => 13,
    'A' => 14
  }.freeze

  attr_accessor :cards, :values, :suits, :low_ace_values, :distinct_values
  attr_accessor :low_ace_max_val, :low_ace_min_val, :low_ace_max_to_min

  def initialize(arr)
    @cards = arr
    @values = []
    @suits = []
    @low_ace_values = []

    arr.each do |card|
      @suits << card[-1]
      @values << (FACE_TO_VAL.key?(card[0...-1]) ? FACE_TO_VAL[card[0...-1]] : card[0...-1])
    end

    if values.include?(14)
      @low_ace_values = values.map { |val| (val == 14 ? 1 : val) }
    end
  end

  def distinct_values
    values.uniq.size
  end

  def low_ace_max_val
    low_ace_values.map(&:to_i).max
  end

  def low_ace_min_val
    low_ace_values.map(&:to_i).min
  end

  def low_ace_max_to_min
    low_ace_values.empty? ? nil : low_ace_max_val - low_ace_min_val
  end

  def max_val
    values.map(&:to_i).max
  end

  def min_val
    values.map(&:to_i).min
  end

  def max_to_min
    max_val - min_val
  end

  def distinct_suits
    suits.uniq.size
  end

  def straight?
    distinct_values == 5 && (max_to_min == 4 || low_ace_max_to_min == 4)
  end

  def flush?
    distinct_suits == 1
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    # binding.pry
    distinct_values == 2 && (values.map(&:to_i).count(max_val) == 4 || values.map(&:to_i).count(min_val) == 4)
  end

  def full_house?
    distinct_values == 2
  end

  def three_of_a_kind?
    # binding.pry
    result = nil
    values.each do |val|
      result = true if values.map(&:to_i).count(val.to_i) == 3
    end
    result
  end

  def pairs
    result = []
    values.each do |val|
      result << val if values.map(&:to_i).count(val.to_i) == 2
    end
    result
  end

  def pair_count
    # binding.pry
    pairs.uniq.size
  end

  def two_pair?
    pair_count == 2
  end

  def one_pair?
    pair_count == 1
  end

  def hand_value
    # binding.pry
    result = nil
    if straight_flush?
      result = ['straight flush', max_val] if max_to_min == 4
      result = ['straight flush', low_ace_max_val] if low_ace_max_to_min == 4
    elsif four_of_a_kind?
      if values.map(&:to_i).count(max_val) == 4
        result = ['four of a kind', max_val]
      else
        result = ['four of a kind', min_val]
      end
    elsif full_house?
      if values.map(&:to_i).count(max_val) == 3
        result = ['full house', max_val]
      else
        result = ['full house', min_val]
      end
    elsif flush?
      result = ['flush', max_val]
    elsif straight?
      result = ['straight', max_val]
    elsif three_of_a_kind?
      result = ['three of a kind', max_val]
    elsif two_pair?
      result = ['two pair', pairs.map(&:to_i).max]
    elsif one_pair?
      result = ['one pair', pairs.max]
    else
      result = ['high card', max_val]
    end
    result
  end
end


# hand = Hand.new(%w(JC TC 9C 8C 7C))
# puts hand.hand_value == ['straight flush', 11]

# hand = Hand.new(%w(AC 2C 3C 4C 5C))
# puts hand.hand_value == ['straight flush', 5]

# hand = Hand.new(%w(AC KC QC JC TC))
# puts hand.hand_value == ['straight flush', 14]

# # four_of_a_kind
# # e: Hand.new(%w(5C 5D 5H 5S 2D)).value == ['four of a kind', 5]
# #    Hand.new(%w(AC AD AH AS 2D)).value == ['four of a kind', 14]
# #    Hand.new(%w(AC AD AH KS 2D)).value == nil
# puts Hand.new(%w(5C 2D 2H 2S 2D)).hand_value == ['four of a kind', 2]
# puts Hand.new(%w(AC AD AH AS 2D)).hand_value == ['four of a kind', 14]

# # full house
# puts Hand.new(%w(5C 5D 5H 2S 2D)).hand_value == ['full house', 5]
# puts Hand.new(%w(AC AD 2H 2S 2D)).hand_value == ['full house', 2]
# puts Hand.new(%w(AC AD AH 2S 2D)).hand_value == ['full house', 14]

# # flush
# # e: Hand.new(%w(JD 9D 8D 4D 2D)).value == ['flush', J]
# #    Hand.new(%w(AC KC QC JC 6C)).value == ['flush', 14]
# #    Hand.new(%w(AC 4D AH KS 2D)).value == nil

# puts Hand.new(%w(JD 9D 8D 4D 2D)).hand_value == ['flush', 11]
# puts Hand.new(%w(AC KC QC JC 6C)).hand_value == ['flush', 14]
# puts Hand.new(%w(AC KD KH 2S 2D)).hand_value == ['two pair', 13]

# puts Hand.new(%w(JD TD 9D 8D 7C)).hand_value == ['straight', 11]
# puts Hand.new(%w(AC KC QH JC TC)).hand_value == ['straight', 14]
# puts Hand.new(%w(AC 4D AH 4S 2D)).hand_value == ['two pair', 14]

# # three_of_a_kind
# puts Hand.new(%w(JD JH JC 8D 7C)).hand_value == ['three of a kind', 11]
# puts Hand.new(%w(AC AS AH JC TC)).hand_value == ['three of a kind', 14]
# puts Hand.new(%w(AC 4D AH KS 2D)).hand_value == ['one pair', 14]

# puts Hand.new(%w(AC 4D TH KS 2D)).hand_value == ['high card', 14]


class Poker
  NAME_TO_VAL = {
    'straight flush' => 0,
    'four of a kind' => 1,
    'full house' => 2,
    'flush' => 3,
    'straight' => 4,
    'three of a kind' => 5,
    'two pair' => 6,
    'one pair' => 7,
    'high card' => 8
  }.freeze

  attr_accessor :hands, :types

  def initialize(*hands)
    @hands = []
    @types = []
    hands[0].each do |hand|
      # binding.pry
      value = Hand.new(hand).hand_value
      @types << NAME_TO_VAL[value[0]]
      @hands << [NAME_TO_VAL[value[0]], value[1], hand]
    end
  end

  def best_type
    min = nil
    hands.each do |hand|
      if min.nil?
        min = hand[0]
      else
        min = hand[0] if hand[0] < min
      end
    end
    min
  end

  def best_types
    hands.select { |hand| hand[0] == best_type }
  end

  def best_high_card
    high = nil
    best_types.each do |hand|
      if high.nil?
        high = hand[1]
      else
        high = hand[1] if hand[1] > high
      end
    end
    high
  end

  def best_hand
    result = []
    best_types.select { |hand| hand[1] == best_high_card }.each do |val|
      result << val[-1]
    end
    result
  end
end

# spade_straight_to_9 = %w(9S 8S 7S 6S 5S)
# diamond_straight_to_9 = %w(9D 8D 7D 6D 5D)
# three_of_4 = %w(4D 4S 4H QS KS)
# hands = [spade_straight_to_9, diamond_straight_to_9, three_of_4]
# game = Poker.new(hands)
# p game.hands
# p game.best_types
# p game.best_hand

    # high_of_8 = %w(4S 5H 6S 8D 2H)
    # high_of_queen = %w(2S 4H 6S TD QH)
    # game = Poker.new([high_of_8, high_of_queen])
    # p game.hands
    # p game.best_high_card