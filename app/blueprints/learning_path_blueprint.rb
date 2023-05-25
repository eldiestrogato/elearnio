class LearningPathBlueprint < Blueprinter::Base
  identifier :id
  field :title

  view :all do
    association :lp_courses, name: :courses_of_lp, blueprint: LpCourseBlueprint
  end
end
