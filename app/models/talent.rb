class Talent < ApplicationRecord
  has_many :study_units, dependent: :destroy
  has_many :study_lps, dependent: :destroy
end
