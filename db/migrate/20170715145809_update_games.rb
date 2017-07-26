class UpdateGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :nb_players, :integer
  end
end
