class UpdateEventsInfos < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :end_date, :datetime, after: :date
  end
end
