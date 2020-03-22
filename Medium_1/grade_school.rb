# methods
#    add a student's name to the roster for a grade
#    get a list of all students enrolled in a grade
#    get a sorted list of all students in all grades
#        students within a grade sorted alphabetically
#    students have one name
require 'pry'

class School
  attr_accessor :students

  def initialize
    @students = Hash.new([])
  end

  def to_h
    result = Hash.new()
    grades = self.students.keys.sort
    grades.each do |grade|
      result[grade] = self.students[grade]
    end
    result
  end

  def add(student_name, grade)
    if self.students[grade] == []
      self.students[grade] = [student_name]
    else
      self.students[grade] << student_name
      self.students[grade].sort!
    end
  end

  def grade(int)
    self.students[int]
  end
end