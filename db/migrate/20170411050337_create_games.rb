class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :shortname
      t.string :img
      t.boolean :teambased
      t.timestamps
    end
  end
end
