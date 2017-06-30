class CreateUsersGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :users_groups do |t|
      t.string :name
      t.string :tag
      t.string :password
      t.string :salt
      t.string :token
      t.timestamps
    end
  end
end
