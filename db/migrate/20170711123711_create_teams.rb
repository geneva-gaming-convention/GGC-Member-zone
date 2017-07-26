class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :tag
      t.belongs_to :game, index: true
      t.belongs_to :users_group, index: true
      t.timestamps
    end
  end
end
