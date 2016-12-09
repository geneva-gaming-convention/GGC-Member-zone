class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :lastname
      t.string :mail
      t.string :password
      t.string :salt
      t.string :token
      t.belongs_to :address, index: true
      t.timestamps null: false
    end
  end
end
