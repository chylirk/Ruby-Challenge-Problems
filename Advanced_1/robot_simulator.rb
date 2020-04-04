# frozen_string_literal: true

require 'pry'

# nouns: robot, grid, direction (north, south, east, west)
# nouns: coordinates (x, y)
# verbs: receive instructions, verify position

# Class Robot
# instance methods: orient(direction), bearing, turn-right, at(x, y), advance
# instance variables: bearing (symbol), coordinates (array)

class Robot
  DIRECTIONS = %i[east west north south].freeze

  attr_accessor :bearing, :coordinates, :direction

  def initialize
    @bearing = nil
    @coordinates = []
  end

  def orient(direction)
    raise(ArgumentError) unless valid?(direction)

    self.bearing = direction
  end

  def valid?(direction)
    DIRECTIONS.include?(direction)
  end

  def turn_right
    case bearing
    when :north then self.bearing = :east
    when :east then  self.bearing = :south
    when :south then self.bearing = :west
    when :west then  self.bearing = :north
    end
  end

  def turn_left
    case bearing
    when :north then self.bearing = :west
    when :west then  self.bearing = :south
    when :south then self.bearing = :east
    when :east then  self.bearing = :north
    end
  end

  def at(x, y)
    self.coordinates = [x, y]
  end

  def advance
    case bearing
    when :north then coordinates[1] += 1
    when :west then  coordinates[0] -= 1
    when :south then coordinates[1] -= 1
    when :east then  coordinates[0] += 1
    end
  end
end

# Class Simulator
# instance methods: instructions (string), place(robot, x:, y:, direction: )
# instance methods: evaluate (robot, string)

class Simulator
  COMMANDS = {
    'L' => :turn_left,
    'R' => :turn_right,
    'A' => :advance
  }.freeze

  def place(robot, x: nil, y: nil, direction: nil)
    robot.at(x, y)
    robot.orient(direction)
  end

  def instructions(str)
    str.chars.map { |com| COMMANDS[com] }
  end

  def evaluate(robot, commands)
    orders = instructions(commands)

    orders.each do |com|
      robot.send(com)
    end
  end
end
