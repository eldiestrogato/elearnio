class LearningPathCourseBlueprint < Blueprinter::Base
  identifier :id

  field :course_number
  association :course, blueprint: CourseBlueprint, view: :all
end
