class AddValidateUsersField < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :validated, :boolean, default: false
  end
end
