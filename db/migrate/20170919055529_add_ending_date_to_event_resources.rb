class AddEndingDateToEventResources < ActiveRecord::Migration[5.0]
  def change
    add_column :event_resources, :registration_end_at, :datetime, default: nil
  end
end
