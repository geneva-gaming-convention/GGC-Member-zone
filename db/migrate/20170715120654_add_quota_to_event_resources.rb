class AddQuotaToEventResources < ActiveRecord::Migration[5.0]
  def change
    add_column :event_resources, :quota, :integer
    add_column :event_resources, :locked_quota, :integer
  end
end
