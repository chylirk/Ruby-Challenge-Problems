require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require_relative 'odd_words'

class OddWordsTest < Minitest::Test
  def setup
  end

  def test_one_word
    str = 'whats'
    expected_result = "w\nh\na\nt\ns\n"
    assert_output(expected_result) { OddWords.translate(str) }
  end

  def test_two_words
    # skip
    str = 'whats the'
    expected_result = "w\nh\na\nt\ns\n \ne\nh\nt\n"
    assert_output(expected_result) { OddWords.translate(str) }
  end

  def test_five_words
    # skip
    str = 'whats the matter with kansas'
    expected_result = "w\nh\na\nt\ns\n \ne\nh\nt\n \nm\na\nt\nt\ne\nr\n \nh\nt\ni\nw\n \nk\na\nn\ns\na\ns\n" 
    assert_output(expected_result) { OddWords.translate(str) }
  end

  def test_point
    # skip
    str = 'whats.'
    expected_result = "w\nh\na\nt\ns\n.\n"
    assert_output(expected_result) { OddWords.translate(str) }
  end

  def test_point_two_words
    # skip
    str = 'whats the.'
    expected_result = "w\nh\na\nt\ns\n \ne\nh\nt\n.\n" 
    assert_output(expected_result) { OddWords.translate(str) }
  end

  def test_point_five_words
    # skip
    str = 'whats the matter with kansas.'
    expected_result = "w\nh\na\nt\ns\n \ne\nh\nt\n \nm\na\nt\nt\ne\nr\n \nh\nt\ni\nw\n \nk\na\nn\ns\na\ns\n.\n"
    assert_output(expected_result) { OddWords.translate(str) }
  end

  def test_multiple_spaces
    str = 'hello word .'
    expected_result = "h\ne\nl\nl\no\n \nd\nr\no\nw\n.\n"
    assert_output(expected_result) { OddWords.translate(str) }
  end

  def test_input_error
    str = 'What the F@#K!'
    assert_raises(ArgumentError) { OddWords.translate(str) }
  end
end
