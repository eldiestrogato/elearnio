class AuthorBlueprint < Blueprinter::Base
  identifier :id
  field :name

  view :all do
    association :courses, name: :courses, blueprint: CourseBlueprint
  end
end
