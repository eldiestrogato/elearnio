class LearningPath < ApplicationRecord
  has_many :learning_path_courses, dependent: :destroy
  has_many :courses, through: :learning_path_courses
  has_many :study_learning_paths, dependent: :destroy

  accepts_nested_attributes_for :learning_path_courses
  validates_presence_of :learning_path_courses, on: :create

  validates :title, presence: true
end
