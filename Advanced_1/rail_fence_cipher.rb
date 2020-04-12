# frozen_string_literal: true

require 'pry'

class RailFenceCipher
  def self.first_index(int, iter, idx)
    (int * 2 - 2) * iter + (int * 2 - idx - 2)
  end

  def self.second_index(int, iter, idx)
    (int * 2 - 2) * iter + idx
  end

  def self.code_array(str, int)
    arr_of_arr = []
    int.times { arr_of_arr << [] }
    arr_of_arr.each_with_index do |arr, idx|
      (0..str.size).each do |x|
        arr << first_index(int, x, idx)
        arr << second_index(int, x, idx)
      end
    end
    arr_of_arr.map! { |subarr| subarr.uniq.sort }
  end

  def self.encode(str, int)
    return str if int == 1

    arr_of_arr = code_array(str, int)

    arr_of_arr.map! do |subarr|
      subarr.map { |idx| str[idx] }
    end

    arr_of_arr.map(&:compact).join
  end

  def self.decode(str, int)
    return str if int == 1

    arr_of_arr = code_array(str, int)

    idx_arr = []
    arr_of_arr.each { |subarr| idx_arr += subarr }

    idx_arr.select! { |char| char < str.size }

    result = ''

    idx_arr.zip(str.chars)
           .sort! { |a, b| a[0] <=> b[0] }
           .each { |subarr| result += subarr[1] }

    result
  end
end
