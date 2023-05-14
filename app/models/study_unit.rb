class StudyUnit < ApplicationRecord
  belongs_to :talent
  belongs_to :studyable, polymorphic: true
end
