class AddUserResetToken < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :reset_token, :string
    add_column :users, :reseted_at, :datetime
  end
end
