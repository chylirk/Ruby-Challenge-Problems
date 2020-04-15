# frozen_string_literal: true

require 'pry'

class Hand
  FACE_VAL = {
    'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14
  }.freeze

  attr_reader :values, :suits

  def initialize(cards)
    @values = []
    @suits = []
    cards.each do |card|
      @suits << card[-1]
      @values << (FACE_VAL.key?(card[0]) ? FACE_VAL[card[0]] : card[0].to_i)
    end
  end

  def distinct_values
    values.uniq.size
  end

  def max_val
    values.max
  end

  def min_val
    values.min
  end

  def max_to_min
    max_val - min_val
  end

  def distinct_suits
    suits.uniq.size
  end

  def straight?
    distinct_values == 5 && max_to_min == 4
  end

  def flush?
    distinct_suits == 1
  end

  def straight_flush?
    straight? && flush?
  end

  def four_of_a_kind?
    max_val_quads
  end

  def full_house?
    distinct_values == 2
  end

  def three_of_a_kind?
    max_val_trips
  end

  def n_of_a_kind(int)
    values.select { |v| values.count(v) == int }
  end

  def pairs
    n_of_a_kind(2)
  end

  def max_val_trips
    n_of_a_kind(3)[0]
  end

  def max_val_quads
    n_of_a_kind(4)[0]
  end

  def pair_count
    pairs.uniq.size
  end

  def two_pair?
    pair_count == 2
  end

  def one_pair?
    pair_count == 1
  end

  def hand_value
    if straight_flush? then ['straight flush', max_val]
    elsif four_of_a_kind? then ['four of a kind', max_val_quads]
    elsif full_house? then ['full house', max_val_trips]
    elsif flush? then ['flush', max_val]
    elsif straight? then ['straight', max_val]
    elsif three_of_a_kind? then ['three of a kind', max_val_trips]
    elsif two_pair? then ['two pair', pairs.max]
    elsif one_pair? then ['one pair', pairs.max]
    else ['high card', max_val]
    end
  end
end

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
      value = Hand.new(hand).hand_value
      @types << NAME_TO_VAL[value[0]]
      @hands << [NAME_TO_VAL[value[0]], value[1], hand]
      add_deuce_ace(hand) if hand.join.include?('A')
    end
  end

  def add_deuce_ace(hand)
    low_hand = hand.map do |card|
      card.include?('A') ? card.tr('A', '1') : card
    end
    low_val = Hand.new(low_hand).hand_value
    @types << NAME_TO_VAL[low_val[0]]
    @hands << [NAME_TO_VAL[low_val[0]], low_val[1], hand]
  end

  def best_type
    min = nil
    hands.each do |hand|
      if min.nil?
        min = hand[0]
      elsif hand[0] < min
        min = hand[0]
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
      elsif hand[1] > high
        high = hand[1]
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
