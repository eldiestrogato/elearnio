class LearningPathCourse < ApplicationRecord
  belongs_to :learning_path
  belongs_to :course
end
