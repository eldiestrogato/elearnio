class ChangeStudyLpsToStudyLearningPaths < ActiveRecord::Migration[6.0]
  def change
    rename_table :study_lps, :study_learning_paths
  end
end
