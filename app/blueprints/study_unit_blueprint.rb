class StudyUnitBlueprint < Blueprinter::Base
  identifier :id
  field :is_course_completed
  association :course, name: :course, blueprint: CourseBlueprint

  view :all do
    association :talent, name: :talent, blueprint: TalentBlueprint
  end
end
