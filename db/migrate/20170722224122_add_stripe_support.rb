class AddStripeSupport < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :remote_id, :string
    add_column :registrations, :paid, :boolean
  end
end
