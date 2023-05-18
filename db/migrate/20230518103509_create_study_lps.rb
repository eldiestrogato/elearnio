class CreateStudyLps < ActiveRecord::Migration[6.0]
  def change
    create_table :study_lps do |t|
      t.belongs_to :talent, null: false, foreign_key: true
      t.belongs_to :learning_path, null: false, foreign_key: true

      t.timestamps
    end
  end
end
