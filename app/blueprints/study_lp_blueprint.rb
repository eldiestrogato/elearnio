class StudyLpBlueprint < Blueprinter::Base
  identifier :id
  association :learning_path, name: :learning_path, blueprint: LearningPathBlueprint

  view :all do
    association :talent, name: :talent, blueprint: TalentBlueprint
  end
end
