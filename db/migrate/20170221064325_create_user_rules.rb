class CreateUserRules < ActiveRecord::Migration[5.0]
  def change
    create_table :user_rules do |t|
      t.string :name
      t.text :description
      t.integer :value
      t.timestamps
    end
  end
end
