class Course < ApplicationRecord
  has_many :lp_courses, dependent: :destroy
  has_many :learning_paths, through: :lp_courses
  has_many :study_units, as: :studyable
  belongs_to :author
end
