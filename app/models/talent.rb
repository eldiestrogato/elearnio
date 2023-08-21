class Talent < ApplicationRecord
  has_many :study_units, dependent: :destroy
  has_many :study_learning_paths, dependent: :destroy

  validates :name, presence: true
end
