class Enrollment < ActiveRecord::Base
 # belongs one user / has one course

  belongs_to :user,
    primary_key: :id,
    foreign_key: :student_id,
    class_name: :User

  belongs_to :course,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Course
end
