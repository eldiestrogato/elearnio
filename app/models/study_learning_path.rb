class StudyLearningPath < ApplicationRecord
  belongs_to :talent
  belongs_to :learning_path
  validates_uniqueness_of :learning_path, scope: :talent_id
end
