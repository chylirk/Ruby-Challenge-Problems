require 'pry'

class WordProblem
  attr_reader :problem, :better_problem

  OPERATIONS = {
    "plus" => "+",
    "minus" => "-",
    "multiplied by" => "*",
    "divided by" => "/"
  }.freeze

  def initialize(str)
    # @problem = str.gsub('?', '').gsub('by', '').split[2..-1]

    @problem = str[0..-2]
    OPERATIONS.each do |k, v|
      @problem.gsub!(k, v)
    end
    @problem = @problem.split[2..-1]
    @problem.map! { |val| integer?(val) ? val.to_i : val }
  end

  def integer?(str)
    str == str.to_i.to_s
  end

  def operation?(obj)
    OPERATIONS.values.include?(obj)
  end

  def answer
    result = nil

    self.problem.each.with_index do |obj, idx|
      # binding.pry
      if obj.is_a?(Integer)
        result = obj if result.nil? #.to_i if result.nil?
      elsif operation?(obj)
        result = result.method(obj).(problem[idx+1])#.to_i)
      else
        # binding.pry
        raise ArgumentError
      end
    end
    result
  end
end

# p WordProblem.new('What is 1 plus 1?').problem
# p WordProblem.new('What is 1 plus 1?').answer
# p WordProblem.new('What is 1 plus 1?').better_problem
# p WordProblem.new('What is 1 plus 1 divided by 1?').answer