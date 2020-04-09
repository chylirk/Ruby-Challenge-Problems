# frozen_string_literal: true

require 'pry'

# methods: rows, columns, saddle_points
#
# rows
#    o: array of arrays representing the rows of a matrix
#    e: ("1 2\n10 20") => [[1, 2], [10, 20]]
#    d: string => array => array
#    a: split the input string at the "\n"
#       split the subarrays by space, map to integers, join
#    c:

# columns
#    p: array of arrays representing the columns of a matrix
#    e: ("1 2\n10 20") => [[1, 10], [2, 20]]
#    d: string => array => array
#    a: call the rows method to get an array of arrays
#       get the size of the first array
#       result = []
#       (0..size - 1).each do |idx|
#           new_arr = []
#           loop over all arrays
#               new array < arr[idx]
#           end
#           result << new_arr
#       result

# saddle_points
#    o:

class Matrix
  attr_accessor :matrix

  def initialize(str)
    str_arr = str.split("\n")
    @matrix = str_arr.map { |arr| arr.split.map(&:to_i) }
  end

  def rows
    matrix
  end

  def columns
    columns = []
    item_count = matrix[0].size
    (0..item_count - 1).each do |idx|
      col = []
      matrix.each do |row|
        col << row[idx]
      end
      columns << col
    end
    columns
  end

  def saddle_point?(row, col)
    matrix[row][col] == rows[row].max &&
      matrix[row][col] == columns[col].min
  end

  def saddle_points
    points = []
    col_count = rows[0].size
    row_count = columns[0].size
    (0..row_count - 1).each do |row_idx|
      (0..col_count - 1).each do |col_idx|
        points << [row_idx, col_idx] if saddle_point?(row_idx, col_idx)
      end
    end
    points
  end
end

# matrix = Matrix.new("18 3 39 19 91\n38 10 8 77 320\n3 4 8 6 7")
# puts matrix.saddle_points == [[2, 2]]
