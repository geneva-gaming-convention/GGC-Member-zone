class AddVisibleToEventResources < ActiveRecord::Migration[5.0]
  def change
    add_column :event_resources, :visible, :boolean, after: :remote_url
  end
end
