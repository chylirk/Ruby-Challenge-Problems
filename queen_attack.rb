# frozen_string_literal: true

require 'pry'

class Square
  attr_accessor :occupier

  def initialize
    @occupier = '_'
  end

  def placed(occupier)
    @occupier = occupier
  end

  def to_s
    occupier.to_s
  end

  def reset
    initialize
  end
end

class Queen
  attr_accessor :color, :location

  def initialize(color, location = [])
    @color = color
    @location = location
  end

  def place(location)
    self.location = location
  end

  def to_s
    color
  end
end

class Board
  SIZE = 8

  attr_accessor :board

  def initialize
    @board = []
    SIZE.times do
      row = []
      SIZE.times do
        row << Square.new
      end
      @board << row
    end
  end

  def [](int)
    board[int]
  end

  def place(queen, row, column)
    board[row][column].placed(queen)
  end

  def to_s
    board.map do |line|
      line.map(&:to_s).join(' ')
    end.join("\n")
  end
end

class Queens
  COLORS = %w[W B].freeze

  attr_accessor :white_queen, :black_queen, :board

  def initialize(white: [0, 3], black: [7, 3])
    raise(ArgumentError) if white == black

    @white_queen = Queen.new(COLORS[0], white)
    @black_queen = Queen.new(COLORS[1], black)
    @board = Board.new
    place_pieces
  end

  def place_pieces
    board.place(white_queen, white[0], white[1])
    board.place(black_queen, black[0], black[1])
  end

  def white
    white_queen.location
  end

  def black
    black_queen.location
  end

  def to_s
    board.to_s
  end

  def attack?
    row_col_attack? || diagonal_attack?
  end

  def row_col_attack?
    row_gap.zero? || col_gap.zero?
  end

  def row_gap
    (white_queen.location[0] - black_queen.location[0]).abs
  end

  def col_gap
    (white_queen.location[1] - black_queen.location[1]).abs
  end

  def diagonal_attack?
    row_gap == col_gap
  end
end
