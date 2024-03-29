require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!
require_relative 'luhn'

class LuhnTest < Minitest::Test
  def test_addends
    luhn = Luhn.new(12_121)
    assert_equal [1, 4, 1, 4, 1], luhn.addends
  end

  def test_too_large_addend
    # skip
    luhn = Luhn.new(8631)
    assert_equal [7, 6, 6, 1], luhn.addends
  end

  def test_checksum
    # skip
    luhn = Luhn.new(4913)
    assert_equal 22, luhn.checksum
  end

  def test_checksum_again
    # skip
    luhn = Luhn.new(201_773)
    assert_equal 21, luhn.checksum
  end

  def test_invalid_number
    # skip
    luhn = Luhn.new(738)
    refute luhn.valid?
  end

  def test_valid_number
    # skip
    luhn = Luhn.new(8_739_567)
    assert luhn.valid?
  end

  def test_create_valid_number
    # skip
    number = Luhn.create(123)
    assert_equal 1230, number
  end

  def test_create_other_valid_number
    # skip
    number = Luhn.create(873_956)
    assert_equal 8_739_567, number
  end

  def test_create_yet_another_valid_number
    # skip
    number = Luhn.create(837_263_756)
    assert_equal 8_372_637_564, number
  end
end
