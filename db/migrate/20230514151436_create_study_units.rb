class CreateStudyUnits < ActiveRecord::Migration[6.0]
  def change
    create_table :study_units do |t|
      t.boolean :is_course_completed, default: false
      t.belongs_to :talent, null: false, foreign_key: true
      t.belongs_to :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
