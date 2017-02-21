class CreatePrivileges < ActiveRecord::Migration[5.0]
  def change
    create_table :privileges do |t|
      t.belongs_to :user, index: true
      t.belongs_to :user_rule, index: true
      t.timestamps
    end
  end
end
