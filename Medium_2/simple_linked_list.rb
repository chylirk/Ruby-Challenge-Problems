require 'pry'

class Element
  attr_accessor :datum, :next

  def initialize(datum, nxt=nil)
    @datum = datum
    @next = nxt
  end

  def tail?
    @next.nil?
  end
end

class SimpleLinkedList
  attr_reader :arr

  def initialize(arr=[])
    @arr = arr
  end

  def size
    arr.size
  end

  def empty?
    arr.empty?
  end

  def push(obj)
    if arr.empty?
      arr.push(Element.new(obj))
    else
      arr.push(Element.new(obj, arr.last))
    end
  end

  def peek
    return nil if head.nil?
    head.datum
  end

  def head
    arr.last
  end

  def pop
    arr.pop.datum
  end

  def self.from_a(arr)
    return SimpleLinkedList.new([]) if arr.nil? || arr.empty?

    l = SimpleLinkedList.new([])
    arr.reverse_each do |val|
      # binding.pry
      l.push(val)
    end
    l
  end

  def to_a
    arr.map { |el| el.datum }.reverse
  end

  def reverse
    SimpleLinkedList.from_a(self.to_a.reverse)
  end
end
