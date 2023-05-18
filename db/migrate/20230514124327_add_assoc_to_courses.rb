class AddAssocToCourses < ActiveRecord::Migration[6.0]
  def change
    add_belongs_to :courses, :author, index: true, foreign_key: true, null: false
  end
end
