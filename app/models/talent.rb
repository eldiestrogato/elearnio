class Talent < ApplicationRecord
  has_many :study_units
  has_many :study_lps
end
