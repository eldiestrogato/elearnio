class CreateLpCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :lp_courses do |t|
      t.belongs_to :learning_path, null: false, foreign_key: true
      t.belongs_to :course, null: false, foreign_key: true
      t.integer :course_number

      t.timestamps
    end
  end
end
