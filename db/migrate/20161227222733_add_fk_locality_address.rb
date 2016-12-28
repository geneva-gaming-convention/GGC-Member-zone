class AddFkLocalityAddress < ActiveRecord::Migration[5.0]
  def change
    add_reference :addresses, :locality, index: true
  end
end
