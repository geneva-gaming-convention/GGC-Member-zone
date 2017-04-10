class AddEventsVisibilityAndDiscordUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :chat_url, :text, after: :shortname
    add_column :events, :visible, :boolean, after: :date
  end
end
