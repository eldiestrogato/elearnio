class LearningPath < ApplicationRecord
  has_many :lp_courses, dependent: :destroy
  has_many :courses, through: :lp_courses
  has_many :study_units, as: :studyable
end
