class CreateStates < ActiveRecord::Migration[5.0]
  def change
    create_table :states do |t|
      t.string :name
      t.belongs_to :country, index: true
      t.timestamps
    end
  end
end
