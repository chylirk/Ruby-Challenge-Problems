# frozen_string_literal: true

require 'pry'

class CircularBuffer
  class BufferEmptyException < StandardError; end
  class BufferFullException < StandardError; end

  attr_accessor :size, :buffer, :idx_write, :idx_oldest

  def initialize(size)
    @size = size
    @buffer = [nil] * size
    @idx_write = 0
    @idx_oldest = 0
  end

  def write(val)
    raise BufferFullException if buffer.none?(nil)

    return if val.nil?

    buffer[idx_write] = val
    increment_write_index
  end

  def read
    raise BufferEmptyException if buffer.all?(nil)

    value, buffer[idx_oldest] = buffer[idx_oldest], nil
    increment_oldest_index
    value
  end

  def clear
    buffer.map! { |_| nil }
  end

  def write!(val)
    return if val.nil?
    
    if buffer.none?(nil) && val
      buffer[idx_write] = val
      # self.idx_write = (self.idx_write + 1) % self.size
      increment_write_index
      increment_oldest_index
    else
      write(val)
    end
  end

  def increment_write_index
    self.idx_write = ((idx_write + 1) % size)
  end

  def increment_oldest_index
    self.idx_oldest = ((idx_oldest + 1) % size)
  end
end

# write 1
#    written to array at idx = idx_oldest
#    idx_write += 1
#    idx_oldest remains the same

# read
#    read from the array at idx_oldest
#    replace value at idx_oldest with empty (nil?)
#    idx_oldest += 1
#    idx_write remains the same
