class CourseBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :body

  view :min do
    association :learning_path, blueprint: LearningPathBlueprint
  end

  view :all do
    association :author, blueprint: AuthorBlueprint
  end

end
