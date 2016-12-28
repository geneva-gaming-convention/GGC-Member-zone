class CreateLocalities < ActiveRecord::Migration[5.0]
  def change
    create_table :localities do |t|
      t.string :name
      t.integer :postal_code
      t.belongs_to :state, index: true
      t.timestamps
    end
  end
end
