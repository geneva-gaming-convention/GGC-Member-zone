class AddInvitationRegistrations < ActiveRecord::Migration[5.0]
  def change
    add_column :registrations, :invitation, :boolean, default: false
    add_column :registrations, :invitation_used, :boolean, default: false
    add_column :registrations, :token, :string
  end
end
