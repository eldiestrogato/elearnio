class TalentBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :is_author

  view :all do
    association :study_units, name: :talent_study_units, blueprint: StudyUnitBlueprint
    association :study_lps, name: :talent_study_lps, blueprint: StudyLpBlueprint
  end

end
