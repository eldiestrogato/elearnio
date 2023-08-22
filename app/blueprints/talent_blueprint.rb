class TalentBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :is_author

  view :all do
    association :study_units, name: :talent_study_units, blueprint: StudyUnitBlueprint
    association :study_learning_paths, name: :talent_study_learning_paths, blueprint: StudyLearningPathBlueprint
  end

end
