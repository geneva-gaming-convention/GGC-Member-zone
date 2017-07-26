class UpdateRegistrationModel < ActiveRecord::Migration[5.0]
  def change
    add_reference :registrations, :event_resource, index: true
    add_reference :registrations, :event_pack, index: true
    add_reference :registrations, :team, index: true
    add_reference :registrations, :users_group, index: true
    add_column :registrations, :is_a_player, :boolean
  end
end
