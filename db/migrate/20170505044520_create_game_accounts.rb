class CreateGameAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :game_accounts do |t|
      t.string :name
      t.string :profile_url
      t.string :image
      t.string :account_id
      t.datetime :last_seen
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
