# frozen_string_literal: true

require 'pry'

class RuntimeError < StandardError; end

class Game
  attr_accessor :rolls, :frames

  def initialize
    @rolls = []
    @frames = []
  end

  def roll(bowl)
    raise(RuntimeError) if invalid_bowl?(bowl)

    raise(RuntimeError) if game_complete?

    bowl.is_a?(Array) ? bowl.each { |val| roll(val) } : rolls << bowl

    self.frames = []
    create_frames

    raise(RuntimeError) if invalid_frame?
  end

  def invalid_bowl?(bowl)
    bowl.negative? || bowl > 10
  end

  def game_complete?
    return true if frames[9] && frames[9][2]

    (frames[9][0..1].reduce(&:+) < 10) if frames[9] && frames[9][1]
  end

  def invalid_frame?
    invalid_normal_frame? || invalid_final_frame?
  end

  def invalid_normal_frame?
    frames[0..8].select { |frame| frame.none?(nil) }
                .map { |val_frame| val_frame.reduce(&:+) }
                .any? { |val| val > 10 }
  end

  def invalid_final_frame?
    frames[-1].size == 3 && frames[-1][-1] == 6
  end

  def create_frames
    idx = 0
    loop do
      break if idx >= rolls.size

      val = rolls[idx]
      if final_frame?
        frames << update_final_frame(val, idx)
        idx += 3
      elsif strike?(val)
        frames << [val]
        idx += 1
      else
        frames << [val, rolls[idx + 1]]
        idx += 2
      end
    end
  end

  def update_final_frame(val, idx)
    update_roll = rolls[idx..idx + 2]
    if strike?(val)
      update_roll
    elsif rolls[idx + 1].nil?
      [val, nil]
    elsif spare?(val, idx)
      update_roll
    else
      rolls[idx..idx + 1]
    end
  end

  def spare?(val, idx)
    val + rolls[idx + 1] == 10
  end

  def final_frame?
    frames.size == 9 && frames[8].none?(nil)
  end

  def strike?(val)
    val == 10
  end

  def invalid_score?
    frames.size < 10 || frames[-1].any?(nil) || frames[-1].size == 1
  end

  def score
    raise(RuntimeError) if invalid_score?

    result = 0
    frames.each_with_index do |frame, idx|
      result += frame[0]
      remainder = frame[1..-1].reduce(&:+)
      next_frame = frames[idx + 1]
      next_first = next_frame[0] if next_frame
      next_second = next_frame[1] if next_frame
      if idx == 9
        result += remainder
      elsif idx == 8 && strike?(frame[0])
        result += (next_first + next_second)
      elsif strike?(frame[0])
        result += next_first
        result += (strike?(next_first) ? frames[idx + 2][0] : next_second)
      elsif frame.reduce(&:+) == 10
        result += (remainder + next_first)
      else
        result += remainder
      end
    end
    result
  end
end
