class LearningPathBlueprint < Blueprinter::Base
  identifier :id
  field :title

  view :all do
    association :learning_path_courses, name: :courses_of_learning_path, blueprint: LearningPathCourseBlueprint
  end
end
