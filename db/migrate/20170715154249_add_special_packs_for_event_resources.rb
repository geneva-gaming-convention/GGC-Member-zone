class AddSpecialPacksForEventResources < ActiveRecord::Migration[5.0]
  def change
    add_reference :event_packs, :event_resource, index: true
  end
end
