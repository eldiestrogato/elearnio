class CreateTalents < ActiveRecord::Migration[6.0]
  def change
    create_table :talents do |t|
      t.string :name
      t.boolean :is_author

      t.timestamps
    end
  end
end
