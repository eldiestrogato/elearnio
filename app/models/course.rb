class Course < ApplicationRecord
  has_many :lp_courses, dependent: :destroy
  has_many :learning_paths, through: :lp_courses
  has_many :study_units, dependent: :destroy
  belongs_to :author

  validates :body, :title, presence: true
end
