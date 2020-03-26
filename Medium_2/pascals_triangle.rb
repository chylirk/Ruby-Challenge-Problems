# frozen_string_literal: true

require 'pry'

# rows method
# i: integer
# o: array of arrays
# e: rows(1) => [[1]]
# e: rows(2) => [[1], [1, 1]]
# 1 [1]
# 2 [1], [1,1]
# 3 [1], [1,1], [1,2,1]
# 4 [1], [1,1], [1, 3, 3, 1]
# 5 [1, 4, 6, 4, 1]
# 6 [1, 5, 10, 10, 5, 1]
# 7 [1, 6, 15, 20, 15, 6, 1]
# 8 [1, 7, 21, 35, 35, 21, 7, 1]
# 9 [1, 8, 28, 56, 70, 56, 28, 8, 1]

# row(1) = [1]
# row(2) = [row(1)[0], row(1)[0]]
# row(3) = [row(2)[0], row(2)[0] + row(2)[1], row(1)[1]]
# row(x)

# triangle = []

# def row(num)
#   return [0] if num == 0
#   return [1] if num == 1

#   # binding.pry
#   result = [nil] * ((num+1) / 2)
#   result.map!.with_index do |arr, idx|
#     # binding.pry
#     if idx == 0
#       row(num-1)[0]
#     else
#       row(num-1)[idx-1] + row(num-1)[idx]
#     end
#   end
#   num.odd? ? result + result.reverse[-(num-1)/2..-1] : result + result.reverse
# end

# p row(2)
# p row(3)
# p row(4)
# p row(5)
# p row(6)

class Triangle
  attr_reader :row_count

  def initialize(int)
    @row_count = int
  end

  def array_generator(num)
    [nil] * ((num + 1) / 2)
  end

  def half_row(num)
    array_generator(num).map.with_index do |_, idx|
      idx.zero? ? row(num - 1)[0] : row(num - 1)[idx - 1] + row(num - 1)[idx]
    end
  end

  def row(num)
    return [0] if num.zero?
    return [1] if num == 1

    if num.odd?
      half_row(num) + half_row(num).reverse[-(num - 1) / 2..-1]
    else
      half_row(num) + half_row(num).reverse
    end
  end

  def rows
    result = []
    (1..row_count).to_a.each do |int|
      result << row(int)
    end
    result
  end
end

# triangle = Triangle.new(10)
# p triangle.rows.last
