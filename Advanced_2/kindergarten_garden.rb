# frozen_string_literal: true

require 'pry'

# nouns: class, plants (grass, clover, radishes, violets)
# nouns: teacher, seeds, dirt, cups, children
#     children( alice, bob, charlie, david, eve, fred,
#               ginny, harriet, ileana, joseph, kincaid,
#               larry )
# each child gets four cups, two per row
# children are assigned cups in alphabetical order

# i: plants from left-to-right, window row first
# i: array of students
# o: which plants belong to which students

# e: see test suite
# d: (string, array) => (array, array) => (array of arrays, array) => hash
# a:
#    split the garden string at the new line
#    row_one is the first entry
#    row_two is the second entry
#    divide row_one at every second element (use each_slice)
#    divide row_two at every second element
#    make a new array with the elements of row_one and row_two
#        loop over one of the rows with index
#        append the block parameter
#        append the result of calling [] on the other row with the index
#    create a hash where the keys are the student names
#        and the values are the subarrays within the array of arrays
#    alphabetize the student names before creating the hash
#
#    most important part is method_mising

class Garden
  attr_reader :students
  attr_accessor :plots, :registry, :row_array, :rows

  STUDENTS = %w[alice bob charlie david eve fred
                ginny harriet ileana joseph kincaid
                larry].freeze
  PLANTS = {
    'R' => :radishes,
    'C' => :clover,
    'G' => :grass,
    'V' => :violets
  }.freeze

  def initialize(garden, students = STUDENTS)
    @rows = garden.split("\n").map do |row|
      row.chars.map { |char| PLANTS[char] }
    end
    @row_array = [[], []]
    @plots = []
    @students = students.map(&:downcase).sort
    @registry = {}
    assign_plots
  end

  def create_rows
    rows.each_with_index do |row, idx|
      row.each_slice(2) { |p| row_array[idx] << p }
    end
  end

  def create_plots
    create_rows
    (0...row_array[0].size).each do |idx|
      plots << [row_array[0][idx], row_array[1][idx]]
    end
  end

  def assign_plots
    create_plots
    students.each_with_index do |student, idx|
      registry[student] = plots[idx].flatten unless plots[idx].nil?
    end
  end

  def method_missing(symbol, *args)
    registry[symbol.to_s] || super
  end

  def respond_to_missing?(symbol, *args)
    registry.key?(symbol.to_s) || super
  end
end
