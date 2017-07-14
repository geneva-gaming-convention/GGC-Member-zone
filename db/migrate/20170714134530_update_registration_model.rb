class UpdateRegistrationModel < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :event_resource_id, :integer
    add_foreign_key :event_resource, :registrations
    add_column :registrations, :event_pack_id, :integer
    add_foreign_key :event_pack, :registrations
    add_column :registrations, :team_id, :integer
    add_foreign_key :team, :registrations
    add_column :registrations, :users_group_id, :integer
    add_foreign_key :users_group, :registrations
    add_column :registrations, :is_a_player, :boolean
  end
end
