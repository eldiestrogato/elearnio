class ChangeLpCoursesToLearningPathCourses < ActiveRecord::Migration[6.0]
  def change
    rename_table :lp_courses, :learning_path_courses
  end
end
