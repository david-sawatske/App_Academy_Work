require_relative 'student'

class Course
  attr_reader  :name, :department, :credits, :students, :days, :time_block

  def initialize(name, department, credits, days, time_block)
    @name = name
    @department = department
    @credits = credits
    @days = days
    @time_block = time_block
    @students = []
  end

  def add_student(student)
    student.enroll(self)
  end

  def conflicts_with?(other_course)
    return false if self.time_block != other_course.time_block

    days.any? { |day| other_course.days.include?(day)}
  end
end
