class CreateGameProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :game_providers do |t|
      t.string :name
      t.string :website
      t.timestamps
    end
    add_reference :game_accounts, :game_provider, index: true
    add_reference :games, :game_provider, index: true
  end
end
