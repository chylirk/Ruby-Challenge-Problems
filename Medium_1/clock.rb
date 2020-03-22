# frozen_string_literal: true

require 'pry'

class Clock
  attr_accessor :hours, :minutes

  def initialize(hour, min)
    # binding.pry
    @hour = hour
    @minutes = min

    wrap

    @hour = @hour % 24
  end

  def wrap
    loop do
      break if @minutes < 60

      @hour += 1
      @minutes -= 60
    end

    loop do
      break if @minutes >= 0

      @hour -= 1
      @minutes += 60
    end
  end

  def self.at(hour, min = 0)
    Clock.new(hour, min)
  end

  def to_s
    format('%02d:%02d', @hour, @minutes)
  end

  def +(other)
    # binding.pry
    Clock.new(@hour, @minutes + other)
  end

  def -(other)
    self.+(-other)
  end

  def ==(other)
    to_s == other.to_s
  end
end

#     clock1 = Clock.at(15, 37)
#     clock2 = Clock.at(15, 36)
#     clock3 = Clock.at(14, 37)
# puts clock1.to_s
# puts clock2.to_s
# puts clock3.to_s
