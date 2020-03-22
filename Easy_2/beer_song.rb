# method bottle_count
# i: one or two integers
# o: two or more integers
#        if one input integer, return the original integer and the integer below
#        if two input integers, return all integers between first and 2nd integers, inclusive
#        replace 0 with 'no more'
# e: BeerSong.new.verse(99) == [99, 98]
#    BeerSong.new.verse(3) == [3, 2]
#    BeerSong.new.verse(0) == [0, 99]
#    BeerSong.new.verse(99, 98) == [99, 98, 97]
#    BeerSong.new.verse(2, 0) == [2, 1, 0, 99]
# d: integer, two integers => array
# a:
#    method takes two values
#        the 2nd value defaults to being the first value
#        array from first value to (second value minus one)

# def bottle_count(int1, int2=int1)
#   (int2..int1).to_a.reverse.map { |val| val < 0 ? 100 + val : val }
# end

# p bottle_count(99)
# p bottle_count(99, 98)
# p bottle_count(2, 0)

# method verse
# i: integer
# o: string with two lines of the song
#        if integer is one, then change bottles to bottle
#        if integer is zero, change integer to "no more" and the next one should be 99"
# e: verse(99) == '99 bottles of beer on the wall, 99 bottles of beer.\n" \ "Take one down and pass it around, 98 bottles of beer on the wall.\n"
# a:
#    string interpolation

# def verse(int)
#   if int > 2
#     "#{int} bottles of beer on the wall, #{int} bottles of beer.\n" \
#     "Take one down and pass it around, #{int-1} bottles of beer on the wall.\n"
#   elsif int == 2
#     "#{int} bottles of beer on the wall, #{int} bottles of beer.\n" \
#     "Take one down and pass it around, #{int-1} bottle of beer on the wall.\n"
#   elsif int == 1
#     "#{int} bottle of beer on the wall, #{int} bottle of beer.\n" \
#     "Take it down and pass it around, no more bottles of beer on the wall.\n"
#   elsif int == 0
#     "No more bottles of beer on the wall, No more bottles of beer.\n" \
#     "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
#   end
# end

# puts verse(99)
# puts verse(2)
# puts verse(1)
# puts verse(0)

# multiple_verses
#    map the array of bottle count with the verse method
#    join the verses with a newline

def multi_verse(int1, int2=int1)
  bottle_count(int1, int2).map { |val| verse(val) }.join("\n")
end

# puts multi_verse(2, 0)

class BeerSong
  def initialize
  end

  def verses(int1, int2=int1)
    bottle_count(int1, int2).map { |val| verse(val) }.join("\n")
  end

  def lyrics
    verses(99, 0)
  end

  def verse(int)
    if int > 2
      "#{int} bottles of beer on the wall, #{int} bottles of beer.\n" \
      "Take one down and pass it around, #{int-1} bottles of beer on the wall.\n"
    elsif int == 2
      "#{int} bottles of beer on the wall, #{int} bottles of beer.\n" \
      "Take one down and pass it around, #{int-1} bottle of beer on the wall.\n"
    elsif int == 1
      "#{int} bottle of beer on the wall, #{int} bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    elsif int == 0
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    end
  end

  def bottle_count(int1, int2=int1)
    (int2..int1).to_a.reverse.map { |val| val < 0 ? 100 + val : val }
  end
end