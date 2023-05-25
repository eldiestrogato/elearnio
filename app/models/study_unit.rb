class StudyUnit < ApplicationRecord
  belongs_to :talent
  belongs_to :course
  validates_uniqueness_of :course, scope: :talent_id
end
