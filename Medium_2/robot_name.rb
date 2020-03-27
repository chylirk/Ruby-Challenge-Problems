# frozen_string_literal: true

require 'pry'
require 'securerandom'

class Robot
  attr_reader :name

  @@names = []

  def initialize
    loop do
      letters = ('A'..'Z').to_a.sample(2, random: SecureRandom).join
      numbers = (0..9).to_a.sample(3, random: SecureRandom).join.to_s
      result = letters + numbers

      unless @@names.include?(result)
        @name = result
        break
      end
    end
  end

  def reset
    initialize
  end
end

# robot = Robot.new
# p robot.name
# robot.reset
# p robot.name
