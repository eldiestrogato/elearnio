class LearningPath < ApplicationRecord
  has_many :lp_courses, dependent: :destroy
  has_many :courses, through: :lp_courses
  has_many :study_lps, dependent: :destroy
  accepts_nested_attributes_for :lp_courses
end
