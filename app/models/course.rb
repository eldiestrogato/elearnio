class Course < ApplicationRecord
  has_many :lp_courses, dependent: :destroy
  has_many :learning_paths, through: :lp_courses
  belongs_to :author
end
