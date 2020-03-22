require 'pry'
require 'date'

class Meetup
  attr_reader :month, :year
  attr_accessor :date

  TEENS = [13, 14, 15, 16, 17, 18, 19]

  DOW = {
    1 => :monday,
    2 => :tuesday,
    3 => :wednesday,
    4 => :thursday,
    5 => :friday,
    6 => :saturday,
    7 => :sunday
  }

  def initialize(month, year)
    @month = month
    @year = year
    @date = nil
  end

  def day(dow, wom)
    self.date = Date.new(self.year, self.month)

    loop do
      break if dow_match(dow) && wom_match(wom)
      # binding.pry
      self.date += 1
    end
    date
  end

  def dow_match(dow)
    DOW[self.date.cwday] == dow
  end

  def wom_match(wom)
    if wom == :teenth
      TEENS.include?(self.date.mday)
    elsif wom == :first
      (1..7).include?(self.date.mday)
    elsif wom == :second
      (8..14).include?(self.date.mday)
    elsif wom == :third
      (15..21).include?(self.date.mday)
    elsif wom == :fourth
      (22..28).include?(self.date.mday)
    elsif wom == :last
      # binding.pry
      !Date.valid_date?(self.year.to_i, self.month.to_i, self.date.mday.to_i+7)
    end
  end
end
