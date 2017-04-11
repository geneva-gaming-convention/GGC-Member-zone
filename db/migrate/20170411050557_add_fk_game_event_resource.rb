class AddFkGameEventResource < ActiveRecord::Migration[5.0]
  def change
    add_reference :event_resources, :game, index: true
  end
end
