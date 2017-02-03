class AddPhoneUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :phone, :string, after: :mail
  end
end
