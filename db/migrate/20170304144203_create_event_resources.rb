class CreateEventResources < ActiveRecord::Migration[5.0]
  def change
    create_table :event_resources do |t|
      t.string :title
      t.text :description
      t.datetime :start_at
      t.boolean :remote
      t.string :remote_url
      t.belongs_to :event, index: true
      t.timestamps
    end
  end
end
