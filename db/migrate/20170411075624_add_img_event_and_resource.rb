class AddImgEventAndResource < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :banner, :string, after: :chat_url
    add_column :event_resources, :banner, :string, after: :remote_url
  end
end
